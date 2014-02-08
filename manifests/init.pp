# graylog2-server installation and basic configuration
#
#
#
### Dependencies ###
# runit, because graylog runs as runit service, so runit should be installed
#
#
### Params ###
# path = full path where graylog2 shall be installed
# user = username for graylog2 user
# uid = userid for graylog2 user
# gid = groupid for graylog2 main user group
# run = start graylog2 using runit
# version = version of graylog2server

class graylog2server (
  $path = '/opt/gralog2',
  $user = 'graylog2',
  $uid = 1042,
  $gid = 1042,
  $run = true,
  $version = '0.20.0-rc.1-1') {

  file { $path:
    ensure  => directory,
    owner   => $user,
    mode    => '0644',
    require => User[$user]
  }

  group { $user:
    ensure => present,
  }

  user { $user:
    ensure  => present,
    home    => $path,
    uid     => $uid,
    gid     => $gid,
    require => Group[$user]
  }

}