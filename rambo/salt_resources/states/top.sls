base:
  'roles:project':
    - match: grain
    - clean
    - basebox
    - basebox.symlink
    - network
    - network.cluster
    - users
    - python
    # - hg
    # - hg.ssh
    # - hg.repo
    # - git
    # - git.ssh
    # - git.repo
    # - database                {# required_in postgres #}
    # - postgresql              {# requires {{ grains['dvcs'] }}.repo #}
    - mongodb
    # - artifacts               {# requires {{ grains['dvcs'] }}.repo, required_in postgres #}
    # - nginx                   {# requires {{ grains['dvcs'] }}.repo #}
    # - venv                    {# requires {{ grains['dvcs'] }}.repo, python #}
    # - venv.pip_requirements   {# requires venv #}
    # - conda                   {# requires users #}
    # - conda.anaconda          {# requires conda #}
    - conda.setup_anaconda_repo
    - conda.anaconda_repo_sync_conda
    # - conda.pip_requirements  {# requires conda #}
    # - conf
    # - django
    # - supervisord
    # - hadoop.ambari
  'roles:prod':
    - match: grain
    - deploy_keys
    - supervisord.start         {# requires supervisor #}
  'roles:dev':
    - match: grain
    - users.aliases             {# requires users #}
