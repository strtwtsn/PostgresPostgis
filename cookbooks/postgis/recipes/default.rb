package "libxml2-dev"


# Download Postgis binary

remote_file "/usr/local/src/postgis-2.0.2.tar.gz" do
source "http://postgis.refractions.net/download/postgis-2.0.2.tar.gz"
end

bash "Extract and install Postgis" do
user "root"
cwd "/usr/local/src"
code <<-EOH
export PATH="$PATH:/usr/local/pgsql/bin"
tar xvzf postgis-2.0.2.tar.gz
cd postgis-2.0.2
./configure
make
make install
EOH
end

bash "configure postgis" do
user "root"
code <<-EOH
/usr/local/pgsql/bin/createdb  -T template0 -O postgres -U postgres -E UTF8 template_postgis
/usr/local/pgsql/bin/createlang plpgsql -U postgres -d template_postgis
/usr/local/pgsql/bin/psql -d template_postgis -U postgres -f /usr/local/pgsql/share/contrib/postgis-2.0/postgis.sql
/usr/local/pgsql/bin/psql -d template_postgis -U postgres -f /usr/local/pgsql/share/contrib/postgis-2.0/spatial_ref_sys.sql
/usr/local/pgsql/bin/psql -d template_postgis -U postgres -f /usr/local/pgsql/share/contrib/postgis-2.0/rtpostgis.sql
/usr/local/pgsql/bin/psql -d template_postgis -U postgres -f /usr/local/pgsql/share/contrib/postgis-2.0/topology.sql
ldconfig
EOH
end

