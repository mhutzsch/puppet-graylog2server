# graylog2-server installation and basic configuration
#
#
### Dependencies ###
# runit, because graylog runs as runit service, so runit should be installed
#
#
### Params ###
# serverpath 
#         * full serverpath where graylog2 shall be installed
# user               
#         * username for graylog2 user
# uid                
#         * userid for graylog2 user
# gid                
#         * groupid for graylog2 main user group
# run                
#         * start graylog2 using runit
# version            
#         * version of graylog2server
# logpath            
#         * where to store logiles when running graylog2-server
# mongodb            
#         * shall a mongodb instance be installed on node
#
####
# Params are use in graylog2.conf
####
# is_master          
#         * default to true
# password_secret    
#         * secret password, defaults to: 7XwnpeaqD0 == foobar
# root_user          
#         * default admin user for graylog2 server
# root_password_sha2
#         * default admin password for graylog2 server, defaults to 'admin'
# plugin_dir
#         * relative or absolute path to graylog2 plugins
# rest_listen_uri
#         * the uri where graylog2 server can receive rest calls
# rest_transport_uri
#         * promoted by graylog2 server for other nodes
# elasticsearch_max_docs_per_indes
#         * how many messages are stored in elasticsearch cluster per index
# elasticsearch_max_number_of_indices
#         * indexes multiple max_docs = messages in system
# retention_strategy
#         * what to do with outdated messages
# elasticsearch_shards
#         * no of shards
# elasticsearch_replicas 
#         * no of replicas, with more replicas queries in cluster are faster
# elasticsearch_index_prefix
#         * prefix for stored messages
# allow_leading_wildcard_searches
#         * if allowed, elasticsearch cluster can become very slow
# elasticsearch_cluster_name
#         * name of the elasticsearch cluster
# elasticsearch_node_name
#         * name for graylog2 server, which is a node in es cluster
# elasticsearch_node_master
#         * graylog2 server shall not be the master in the es cluster
# elasticsearch_node_data
#         * graylog2 server shall not save any data in the es cluster
# elasticsearch_transport_tcp_port
#         * port for es transport
# elasticsearch_http_enabled
#         * enable or disable es http frontend for graylog2 server node
# elasticsearch_discovery_zen_ping_multicast_enabled
#         * multicast enabling / disabling
# elasticsearch_discovery_zen_ping_unicast_hosts
#         * unicast hosts
# elasticsearch_analyzer
#         * how es analyzes
# output_batch_size
#         * no of messages per output batch
# processbuffer_processors
#         * number of parallel running processors
# outputbuffer_processors
#         * number of parallel running processors
# processor_wait_strategy
#         * wait strategy, can be blocking, yielding, sleeping, busy_spinning
# ring_size
#         * power of two ring size
# mongodb_host
#         * graylog stores internal data in a mongodb, specifiy which host here
# mongodb_port
#         * port for mongodb
# mongodb_database
#         * name for database, if does not exist created automatically
# mongodb_useauth
#         * if true, specify user and password
# mongodb_replica_set
#         * if you want to use a mongodb replicaset, set hosts and ports here like this:
#           '192.168.1.1:27017,192.168.1.2:27017,192.168.1.3:27017'
#           if set to false not used in conf
# mongodb_max_connections
#         * no of connections to mongodb, take care of ulimits
# mongodb_threads_allowed_to_block_multiplier
#         * thread pool
# rules_file
#         * Drools rules file
# email_enabled
#         * when true, graylog2 can send email messages
# email_hostname
#         * smtp server
# email_port
#         * smtp port
# email_use_auth
#         * use smtp authentication
# email_use_tls
#         * use tls
# email_use_ssl
#         * use ssl
# email_auth_username
#         * username for smtp server
# email_auth_password
#         * password for smtp server (fail, cleartext password requiered)
# email_subject_prefix
#         * subject for mails
# email_from_email
#         * from field for email 

class graylog2server (
  $serverpath                                         = '/opt/graylog2-server',
  $user                                               = 'graylog2',
  $uid                                                = 1042,
  $run                                                = true,
  $version                                            = '0.20.0-rc.2',
  $logpath                                            = '/var/log/graylog2server',
  $mongodb                                            = true,
  $is_master                                          = 'true',
  $password_secret                                    = '7XwnpeaqD0',
  $root_user                                          = 'admin',
  $root_password_sha2                                 = '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',
  $plugin_dir                                         = 'plugin',
  $rest_listen_uri                                    = "http://$::ipaddress:12900/",
  $rest_transport_uri                                 = "http://$::ipaddress:12900/",
  $elasticsearch_max_docs_per_index                   = '20000000',
  $elasticsearch_max_number_of_indices                = '20',
  $retention_strategy                                 = 'delete',
  $elasticsearch_shards                               = '4',
  $elasticsearch_replicas                             = '0',
  $elasticsearch_index_prefix                         = 'graylog2',
  $allow_leading_wildcard_searches                    = 'false',
  $elasticsearch_cluster_name                         = 'elasticsearch',
  $elasticsearch_node_name                            = 'graylog2-server',
  $elasticsearch_node_master                          = 'false',
  $elasticsearch_node_data                            = 'false',
  $elasticsearch_transport_tcp_port                   = '9350',
  $elasticsearch_http_enabled                         = 'false',
  $elasticsearch_discovery_zen_ping_multicast_enabled = 'false',
  $elasticsearch_discovery_zen_ping_unicast_hosts     = "$::ipaddress:9300",
  $elasticsearch_analyzer                             = 'standard',
  $output_batch_size                                  = '5000',
  $processbuffer_processors                           = '5',
  $outputbuffer_processors                            = '5',
  $processor_wait_strategy                            = 'blocking',
  $ring_size                                          = '1024',
  $mongodb_host                                       = "$::ipaddress",
  $mongodb_port                                       = '27017',
  $mongodb_database                                   = 'graylog2',
  $mongodb_useauth                                    = 'false',
  $mongodb_user                                       = 'graylog2',
  $mongodb_password                                   = 'graylord4ever',
  $mongodb_replica_set                                = 'false',
  $mongodb_max_connections                            = '100',
  $mongodb_threads_allowed_to_block_multiplier        = '5',
  $rules_file                                         = 'false',
  $email_enabled                                      = 'false',
  $email_hostname                                     = 'http://mymailserver',
  $email_port                                         = '587',
  $email_use_auth                                     = 'true',
  $email_use_tls                                      = 'true',
  $email_use_ssl                                      = 'true',
  $email_auth_username                                = 'graylord2',
  $email_auth_password                                = 'graylord4ever',
  $email_subject_prefix                               = '[graylord2]',
  $email_from_email                                   = 'party.gorilla@graylord2.com') {

  if ($mongodb == true) {
    include graylog2server::mongodb
  }

  include graylog2server::service

  # create the user
  include graylog2server::user

  file { $serverpath:
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0644',
    recurse => true,
    require => User[$user]
  }

  file { "${serverpath}/etc":
    ensure  => directory,
    owner   => $user,
    group   => $user,
    mode    => '0644',
    require => File[$serverpath]
  }

  # get and unpack graylog2
  exec { 'download and unpack graylog2-server':
    command => "wget https://github.com/Graylog2/graylog2-server/releases/download/${version}/graylog2-server-${version}.tgz -O ${serverpath}/package.tgz;
      tar xvfz package.tgz;
      rm -rf package.tgz;
      mv graylog2-server-${version}/* ${serverpath};
      rm -rf graylog2-server-${version}",
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    cwd     => $serverpath,
    user    => $user,
    group   => $::group,
    unless  => "test -f ${serverpath}/graylog2-server.jar"
  }

  # create basic graylog2 config file
  file { "${serverpath}/etc/graylog2.conf":
    ensure  => file,
    mode    => '0644',
    owner   => 'graylog2',
    group   => 'graylog2',
    content => template('graylog2server/graylog2.conf.erb'),
    require => File["${serverpath}/etc"],
    notify  => Service['graylog2server']
  }

}