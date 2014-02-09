# graylog2-server installation and basic configuration
#
#
#
### Dependencies ###
# runit, because graylog runs as runit service, so runit should be installed
#
#
### Params ###
# graylog2serverpath = full graylog2serverpath where graylog2 shall be installed
# user     = username for graylog2 user
# uid      = userid for graylog2 user
# gid      = groupid for graylog2 main user group
# run      = start graylog2 using runit
# version  = version of graylog2server
# logpath  = where to store logiles when running graylog2-server
# mongodb  = shall a mongodb instance be installed on node

class graylog2server (
  $graylog2serverpath = '/opt/graylog2-server',
  $user               = 'graylog2',
  $uid                = 1042,
  $run                = true,
  $version            = '0.20.0-rc.1-1',
  $logpath            = '/var/log/graylog2server',
  $mongodb            = true) {

  if ($mongodb == true) {
    include graylog2server::mongodb
  }

  include graylog2server::service

  # create the user
  graylog2server::user { $user:
    user => $user,
    home => $graylog2serverpath,
    uid  => $uid,
  }

  file { $graylog2serverpath:
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0644',
    recurse => true,
    require => User[$user]
  }

  file { "${graylog2serverpath}/etc":
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0644',
    require => File[$graylog2serverpath]
  }

  # get and unpack graylog2
  exec { 'download and unpack graylog2-server':
    command => "wget https://github.com/Graylog2/graylog2-server/releases/download/${version}/graylog2-server-${version}.tgz -O ${graylog2serverpath}/package.tgz;
      tar xvfz package.tgz;
      rm -rf package.tgz;
      mv graylog2-server-${version}/* ${graylog2serverpath};
      rm -rf graylog2-server-${version}",
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    cwd     => $graylog2serverpath,
    user    => $user,
    group   => $::group,
    unless  => "test -f ${graylog2serverpath}/graylog2-server.jar"
  }

  # create basic graylog2 config file
  file { "${graylog2serverpath}/etc/graylog2.conf":
    ensure  => file,
    mode    => '0644',
    owner   => 'graylog2',
    group   => 'graylog2',
    content => template('graylog2server/graylog2.conf.erb'),
    require => File["${graylog2serverpath}/etc"]
  }

}