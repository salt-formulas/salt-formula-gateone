{%- from "gateone/map.jinja" import server with context %}
{%- if server.enabled %}

include:
- python

gateone_tornado_package:
  pip.installed:
  - name: tornado==2.4.1
  - force_reinstall: false
  - require:
    - pkg: python_packages

gateone_packages:
  pkg.installed:
  - names:
    - dtach
    - python-openssl
    - python-kerberos
    - python-imaging
  - require:
    - pip: gateone_tornado_package

{%- if grains.os_family == 'Debian' %}

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

{%- endif %}

/opt/gateone/server.conf:
  file.managed:
  - source: salt://gateone/files/server.conf
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
  - enable: True
  - require:
    - file: /opt/gateone/logs
  - watch:
    - file: /opt/gateone/server.conf

{%- endif %}