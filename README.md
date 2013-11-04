
# GateOne web-based terminal emulator

Gate One is an open source, web-based terminal emulator with a powerful plugin system. It comes bundled with a plugin that turns Gate One into an amazing SSH client but Gate One can actually be used to run any terminal application. You can even embed Gate One into other applications to provide an interface into serial consoles, virtual servers, or anything you like. It's a great supplement to any web-based administration interface.

## Support

* service versions: 1.1
* operating systems: Ubuntu 12.04

## Sample pillar

    gateone:
      server:
      enabled: true
      bind:
        address: '0.0.0.0'
        port: 8888
        protocol: 'tcp'
      pam_realm: master1

## Read more

* http://liftoff.github.io/GateOne/
