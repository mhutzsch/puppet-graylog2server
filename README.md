puppet-graylog2server
=====================

Installs the graylog2 Server (version 0.20.0-RC-1-1)

Usage
=====

clone the repo to your puppet module_path
add the class wherever it fits (eg. nodes.pp)

```
class {"graylog2server":}
```

There are many params you can overwrite when you include the graylog2server class.
See init.pp for details

Dependencies
============

uses runit (see: http://smarden.org/runit/)

```
package {"runit":
  ensure => installed
}
```

when using mongodb installation from this module, the puppetlabs apt module is requierd:
https://github.com/puppetlabs/puppetlabs-apt

Its highly recommended to install your elasticsearch-cluster with this puppet module:
https://github.com/elasticsearch/puppet-elasticsearch

Finally
=======

Setup only tested with Ubuntu 13.10 in vagrant box - pls contribute to improve quality
