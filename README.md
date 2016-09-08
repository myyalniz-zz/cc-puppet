# cc-puppet
<br>
Puppet bootstrap config for cc2016test
<br>

Following environment variables are required.
<br>

export AWS_ACCESS_KEY_ID=xxxxxxxxxxxx
<br>
export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxx
<br>

export AWS_REGION=us-east-1
<br>

Then
<br>

cd /etc/puppet/
<br>
puppet apply manifests/civicrm_instance.pp
<br>

Here instance is created with security group and Elastic IP assigned.
<br>

Login to client and puppet master and setup the puppet agent and puppet master for the auto deployment.
<br>

After puppet is setup execute manually when needed.
<br>

cd /etc/puppet/
<br>
sudo puppet apply manifests/site.pp
<br>

