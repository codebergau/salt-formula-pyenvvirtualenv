{%- from slspath + "/map.jinja" import config with context %}
{%- set pyenv_config = salt['pillar.get']('pyenv') %}

{% if config.users is defined %}
{% for user in config.users %}
{% if user in salt['user.list_users']() %}
#{% if not salt['file.directory_exists' ]('/home/{{ user }}/{{ pyenv_config.install_folder }}/{{ config.install_folder }}') %}
mkdir_pyenvvirtualenv:
  file.directory:
    - name: /home/{{ user }}/{{ pyenv_config.install_folder }}/{{ config.install_folder }}
    - mode: 755
#{% else %}
#  cmd.run:
#    - name: echo "Directory /home/{{ user }}/{{ pyenv_config.install_folder }}/{{ config.install_folder }} already exists"
#{% endif %}

get_repo:
  git.latest:
    - name: {{ config.git_repo }}
    - target: /home/{{ user }}/{{ pyenv_config.install_folder }}/{{ config.install_folder }}

append_bashrc:
  file.append:
    - name: /home/{{ user }}/.bashrc
    - text: 
      - "#pyenvivirtualenv environment paths [managed by saltstack]"
      - eval "$(pyenv virtualenv-init -)"

restart_shell:
  cmd.run:
    - runas: {{ user }}
    - name: exec "$SHELL"
{% else %}
  cmd.run:
    - name: echo "User '{{ user }}' does not exist"
{% endif %}
{% endfor %}
{% else %}
  {%- do salt.log.error('No users defined in map or pillar') -%}
{% endif %}

