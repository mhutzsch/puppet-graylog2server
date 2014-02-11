# class, which generates the graylog2 user
# parameters passed throug main class graylog2server

class graylog2server::user (
  $user = undef,
  $home = undef,
  $uid  = undef) {

  group { "$graylog2server::user":
    ensure => present,
    gid    => "$graylog2server::uid",
  }

  user { "$graylog2server::user":
    ensure  => present,
    home    => "$graylog2server::serverpath",
    uid     => "$graylog2server::uid",
    gid     => "$graylog2server::uid",
    require => Group["$graylog2server::user"]
  }
}