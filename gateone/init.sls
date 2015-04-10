
{%- if pillar.gateone is defined %}
include:
{%- if pillar.gateone.server is defined %}
- gateone.server
{%- endif %}
{%- endif %}
