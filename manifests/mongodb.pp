# Class to install mongodb directly from mongodb inc.
# does not configure anything here, just simply installs a local mongodb
# and starts it

class graylog2server::mongodb {
  case $::osfamily {
    'Debian': {
      class { 'apt': }
      apt::source { '10gen':
        location    => 'http://downloads-distro.mongodb.org/repo/ubuntu-upstart',
        release     => 'dist',
        repos       => '10gen',
        key         => '7F0CEB10',
        key_server  => 'keyserver.ubuntu.com',
        include_src => false
      }

      package { 'mongodb-10gen':
        ensure  => installed,
        require => Apt::Source['10gen']
      }

      service { 'mongodb':
        ensure  => running,
        enable  => true,
        require => Package['mongodb-10gen'],
      }
    }
    default: { fail('not supported os') }
  }
}