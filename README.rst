
=======
GateOne
=======

Gate One is an open source, web-based terminal emulator with a powerful plugin system. It comes bundled with a plugin that turns Gate One into an amazing SSH client but Gate One can actually be used to run any terminal application. You can even embed Gate One into other applications to provide an interface into serial consoles, virtual servers, or anything you like. It's a great supplement to any web-based administration interface.

Support
=======

* service versions: 1.2
* operating systems: Ubuntu 12.04

Sample pillars
==============

    gateone:
      server:
      enabled: true
      bind:
        address: '0.0.0.0'
        port: 8888
        protocol: 'tcp'
      auth:
        engine: pam
        realm: local

Read more
=========

* http://liftoff.github.io/GateOne/
* https://github.com/liftoff/GateOne

Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use Github issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-gateone/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

You can also join salt-formulas-users team and subscribe to mailing list:

    https://launchpad.net/~salt-formulas-users

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

    https://github.com/salt-formulas/salt-formula-gateone

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net
