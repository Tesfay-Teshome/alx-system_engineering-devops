# Create a file in /tmp

file { 'school':
  ensure  => 'present',
  path    => '/tmp/school',
  group   => 'www-data',
  mode    => '0744',
  owner   => 'www-data',
  content => 'I love Puppet',

}
