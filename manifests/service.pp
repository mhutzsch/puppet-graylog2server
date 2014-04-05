# starts and monitors graylog2 service automatically using runit

class graylog2server::service {

  file { '/etc/sv/graylog2server':
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  #notice("logpath: $graylog2server::logpath")
  file { "$graylog2server::logpath":
    ensure  => directory,
    mode    => '0755',
    owner   => 'graylog2',
    group   => 'graylog2',
    require => Exec ['download and unpack graylog2-server']
  }

  file { '/etc/sv/graylog2server/run':
    ensure  => present,
    content => template('graylog2server/run.erb'),
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    notify  => Service['graylog2server'],
  }

  file { '/etc/sv/graylog2server/log':
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  file { '/etc/sv/graylog2server/log/run':
    ensure  => present,
    content => template('graylog2server/log.erb'),
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
  }

  service { 'graylog2server':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    provider   => 'runit',
    require    => File["$graylog2server::logpath", "$graylog2server::serverpath/etc/graylog2.conf"]
  }
}