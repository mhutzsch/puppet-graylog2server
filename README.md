puppet-graylog2web
=====================

Installs the graylog2 web interface (version 0.20.1)

Usage
=====

clone the repo to your puppet module_path
add the class wherever it fits (eg. nodes.pp)

```
class {"graylog2web":}
```

See init.pp for details

Dependencies
============

uses runit (see: http://smarden.org/runit/)

```
package {"runit":
  ensure => installed
}
```

Finally
=======

Setup only tested with Ubuntu 13.10 in vagrant box - pls contribute to improve quality
