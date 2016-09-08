
ec2_securitygroup { 'civicrm-security-group':
  ensure      => present,
  region      => 'us-east-1',
  description => 'Security group for civicrm instances',
  ingress     => [{
    protocol  => 'tcp',
    port      => 80,
    cidr      => '0.0.0.0/0',
  },
  {
    protocol  => 'tcp',
    port      => 443,
    cidr      => '0.0.0.0/0',
  },{
    protocol  => 'tcp',
    port      => 22,
    cidr      => '0.0.0.0/0',
  }],
  tags        => {
    tag_name  => 'value',
  },
}

ec2_instance { 'cc-instance-1':
  ensure        => present,
  region        => 'us-east-1',
  image_id      => 'ami-2d39803a',
  instance_type => 't2.micro',
  key_name => 'myyalniz-test1',
  subnet 	=> 'my-test-subnet',   
  security_groups => ['civicrm-security-group']
}

ec2_elastic_ip { '52.6.141.94':
  ensure   => 'attached',
  instance => 'cc-instance-1',
  region   => 'us-east-1',
}

