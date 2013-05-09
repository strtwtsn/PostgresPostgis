# Download Postgres binary

package "libreadline-dev"

remote_file "/usr/local/src/postgresql-9.2.3.tar.gz" do
source "http://ftp.postgresql.org/pub/source/v9.2.3/postgresql-9.2.3.tar.gz"
end

bash "Extract and install Postgres 9.2" do
user "root"
cwd "/usr/local/src"
code <<-EOH
tar xvzf postgresql-9.2.3.tar.gz
cd postgresql-9.2.3
./configure
make
make install
EOH
end

bash "Create postgres user" do
user "root"
code <<-EOH
read -s -p "Please choose a password for the postgres user: "  password
useradd -m postgres
passwd postgres $password
EOH
end

bash "Create PPE user" do
user "postgres"
code <<-EOH
createuser -P -S -D -R -e ppe
EOH
end





bash "Set postgres paths" do
user "root"
code <<-EOH
echo PATH="/usr/local/pgsql/bin/:$PATH" >> /etc/profile
echo PATH="/usr/local/pgsql/share/contrib/postgis-2.0:$PATH" >> /etc/profile
EOH
end



# Install startup script

bash "Install startup script for Postgresql" do
user "root"
code <<-EOH
cp /usr/local/src/postgresql-9.2.3/contrib/start-scripts/linux /etc/init.d/postgresql
chmod +x /etc/init.d/postgresql
/usr/sbin/update-rc.d -f postgresql defaults
EOH
end

bash "Create data directory" do
code <<-EOH
mkdir /usr/local/pgsql/data
chown postgres:postgres /usr/local/pgsql/data
EOH
end

bash "Initialize data directory" do
user "postgres"
code <<-EOH
/usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data/
EOH
end


# Start postgres service

service "postgresql" do
supports :restart => true, :status => true, :reload => true
action [:enable,:start]
end

template "/usr/local/pgsql/data/pg_hba.conf" do
  source "pg_hba.conf.erb"
  owner "postgres"
  group "postgres"
  mode 0600
  notifies :restart, resources(:service => "postgresql"), :immediately
end

