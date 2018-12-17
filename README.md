# salt-formula-pyenvvirtualenv
Saltstack formula for pyenv virtualenv

Sample Pillar
==============

.. code-block:: yaml

    pyenvvirtualenv:
      git_repo: https://github.com/pyenv/pyenv-virtualenv.git
      install_folder: plugins/pyenv-virtualenv
      users:
        - ubuntu

