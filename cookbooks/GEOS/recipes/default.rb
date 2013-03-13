# Download GEOS binary

remote_file "/usr/local/src/geos-3.3.8.tar.bz2" do
source "http://download.osgeo.org/geos/geos-3.3.8.tar.bz2"
end

bash "Extract and Install GEOS" do
user "root"
cwd "/usr/local/src"
code <<-EOH
tar xvjf geos-3.3.8.tar.bz2
cd geos-3.3.8
./configure
make
make install
EOH
end

