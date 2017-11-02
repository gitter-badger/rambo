{% set os = salt['grains.get']('os') %}

setup_basebox:
  pkg.installed:
    - pkgs:
{% if os == 'Ubuntu' or os == 'Debian' or os == 'RedHat' %}
      - rsync
      - p7zip
      - bzip2
      - zip
      - unzip
      - wget
      - curl
      - nano
      - emacs
{% endif %}
{% if os == 'Ubuntu' or os == 'Debian' %}
      - build-essential
      - libreadline6-dev
      - libbz2-dev
      - libssl-dev
      - libsqlite3-dev
      - libncursesw5-dev
      - libffi-dev
      - libdb-dev
      - libexpat1-dev
      - zlib1g-dev
      - liblzma-dev
      - libgdbm-dev
      - libffi-dev
      - libmpdec-dev
      - libfreetype6-dev
      - libpq-dev
{% endif %}
{% if os == 'Ubuntu' %}
      - libjpeg-turbo8-dev
{% endif %}
{% if os == 'Debian' %}
      - libjpeg62-turbo-dev
{% endif %}
{% if os == 'RedHat' %}
      - epel-release
{% endif %}

{% if os == 'Ubuntu' or os == 'Debian' %}
update_apt_after_setup_basebox:
  cmd.run:
    - name: apt -y update
{% endif %}

{% if os == 'RedHat' %}
update_yum_after_setup_basebox:
  cmd.run:
    - name: yum -y update
{% endif %}
