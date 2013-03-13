# Download proj4 binary

remote_file "/usr/local/src/proj-4.8.0.tar.gz" do
source "http://download.osgeo.org/proj/proj-4.8.0.tar.gz"
end

bash "Extract and install Proj4" do
user "root"
cwd "/usr/local/src"
code <<-EOH
tar xvzf proj-4.8.0.tar.gz
cd proj-4.8.0
./configure
make
make install
EOH
end

