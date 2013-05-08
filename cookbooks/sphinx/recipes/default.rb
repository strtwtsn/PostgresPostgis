remote_file "/usr/local/src/sphinx-0.9.9.tar.gz" do
source "http://sphinxsearch.com/files/archive/sphinx-0.9.9.tar.gz"
end

bash "Extract and install Sphinx" do
user "root"
cwd "/usr/local/src"
code <<-EOH
tar xvzf sphinx-0.9.9.tar.gz
cd sphinx-0.9.9
./configure --with-pgsql --with-pgsql-includes=/usr/local/pgsql/include/ --with-pgsql-libs=/usr/local/pgsql/lib --with-pg-config=/usr/local/pgsql/bin/pg_config --without-mysql
make
make install
EOH
end

