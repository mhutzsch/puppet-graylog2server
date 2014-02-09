# starts and monitors graylog2 service automatically using runit

class graylog2server::service {

  package { 'runit':
    ensure => installed,
  }

  file { '/etc/sv/graylog2server':
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }

  file { '/var/log/graylog2server':
    ensure => directory,
    mode   => '0755',
    owner  => 'graylog2',
    group  => 'graylog2',
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
    require    => File['/var/log/graylog2server']
  }
}