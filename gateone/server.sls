{%- from "linux/map.jinja" import system with context %}
{%- from "gateone/map.jinja" import server with context %}
{%- if server.enabled %}

include:
- python
- git

gateone_source:
  git.latest:
  - name: https://github.com/liftoff/GateOne.git
  - target: /root/GateOne
  - rev: master
  - require:
    - pkg: git_packages

gateone_install:
  cmd.run:
  - name: python setup.py install
  - cwd: /root/GateOne
  - unless: pip freeze | grep gateone
  - require:
    - git: gateone_source

/etc/gateone/conf.d/10server.conf:
  file.managed:
  - source: salt://gateone/files/10server.conf
  - template: jinja
  - require:
    - cmd: gateone_install

/etc/gateone/conf.d/20authentication.conf:
  file.managed:
  - source: salt://gateone/files/20authentication.conf
  - template: jinja
  - require:
    - cmd: gateone_install

gateone_service:
  service.running:
  - name: gateone
  - enable: True
  - watch:
    - file: /etc/gateone/conf.d/10server.conf
    - file: /etc/gateone/conf.d/20authentication.conf

{%- if server.private_key is defined %}
{%- for user_name, user in system.user.iteritems() %}

/var/lib/gateone/users/{{ user_name }}@{{ system.name }}/.ssh:
  file.directory:
  - makedirs: true

/var/lib/gateone/users/{{ user_name }}@{{ system.name }}/.ssh/key:
  file.managed:
  - contents_pillar: gateone:server:private_key

/var/lib/gateone/users/{{ user_name }}@{{ system.name }}/.ssh/key.pub:
  file.managed:
  - contents_pillar: gateone:server:public_key

{%- endfor %}
{%- endif %}

{%- endif %}