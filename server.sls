{% set os_family = salt['grains.item']('os_family')['os_family'] %}

{%- if pillar.gateone.server.enabled %}

include:
- python

gateone_tornado_package:
  pip.installed:
  - name: tornado==2.4.1
  - force_reinstall: false
  - require:
    - pkg: python_packages

{#
kerberos:
  pip.installed:
  - version: 1.1.1
  - require:
    - pkg: python-pip
#}

gateone_packages:
  pkg.installed:
  - names:
    - dtach
    - python-openssl
    - python-kerberos
    - python-imaging
  - require:
    - pip: gateone_tornado_package

{%- if os_family == 'Debian' %}

download_package:
  cmd.run:
  - name: wget https://github.com/downloads/liftoff/GateOne/gateone_1.1-1_all.deb
  - unless: "[ -f /root/gateone_1.1-1_all.deb ]"
  - cwd: /root

gateone_package:
  pkg.installed:
  - sources:
    - gateone: /root/gateone_1.1-1_all.deb
  - require:
    - cmd: download_package

{#
install_package:
  cmd.run:
  - name: sudo dpkg -i gateone_1.1-1_all.deb
  - cwd: /root
  - require:
    - cmd: download_package
#}

{%- endif %}

/opt/gateone/server.conf:
  file:
  - managed
  - source: salt://gateone/conf/server.conf
  - template: jinja
  - require:
    - pkg: gateone_package
    - pkg: gateone_packages

/opt/gateone/logs:
  file:
  - directory
  - mode: 777
  - require:
    - file: /opt/gateone/server.conf

gateone_service:
  service.running:
  - name: gateone
  - require:
    - file: /opt/gateone/logs
    - file: /opt/gateone/server.conf

{%- endif %}