# class, which generates the graylog2 user
# parameters passed throug main class graylog2server

define graylog2server::user (
  $user = undef,
  $home = undef,
  $uid  = undef) {

  group { $user:
    ensure => present,
    gid    => $uid,
  }

  user { $user:
    ensure  => present,
    home    => $home,
    uid     => $uid,
    gid     => $uid,
    require => Group[$user]
  }
}