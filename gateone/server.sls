{%- from "gateone/map.jinja" import server with context %}
{%- if server.enabled %}

include:
- python

gateone_source:
  git.latest:
  - name: https://github.com/liftoff/GateOne.git
  - target: /root/GateOne
  - rev: master
  - require:
    - pkg: gateone_packages
    - pkg: git_packages

gateone_install:
  cmd.run:
  - name: python setup.py install
  - cwd: /root/GateOne
  - unless: pip freeze | grep gateone
  - require:
    - git: gateone_source

/etc/gateone/10server.conf:
  file.managed:
  - source: salt://gateone/files/server.conf
  - template: jinja
  - require:
    - cmd: gateone_install

gateone_service:
  service.running:
  - name: gateone
  - enable: True
  - watch:
    - file: /etc/gateone/10server.conf

{%- endif %}