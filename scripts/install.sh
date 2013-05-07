#!/bin/bash
apt-get -y update
apt-get -y install build-essential zlib1g-dev libssl-dev libreadline-dev libyaml-dev git
cd /usr/local/src
wget http://rubyenterpriseedition.googlecode.com/files/ruby-enterprise-1.8.7-2012.02.tar.gz
tar -xvzf ruby-enterprise-1.8.7-2012.02.tar.gz
cd /usr/local/src/ruby-enterprise-1.8.7-2012.02/
./installer --no-tcmalloc --dont-install-useful-gems --no-dev-docs --auto /usr/local
rm /usr/local/src/ruby-enterprise-1.8.7-2012.02.tar.gz
/usr/local/bin/gem install bundler chef ruby-shadow --no-ri --no-rdoc
sudo git clone https://github.com/strtwtsn/PostgresPostgis.git /var/chef
/usr/local/bin/chef-solo -c /var/chef/config/chefsolo.rb -j /var/chef/roles/ppedb.json
