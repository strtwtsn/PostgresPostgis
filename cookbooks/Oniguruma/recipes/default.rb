remote_file "download Oniguruma" do
  path "/usr/local/src/onig-5.9.2.tar.gz"
  source "http://www.geocities.jp/kosako3/oniguruma/archive/onig-5.9.2.tar.gz"
end 

bash "Extract and install Oniguruma" do
user "root"
cwd "/usr/local/src"
code <<-EOH
tar xvzf onig-5.9.2.tar.gz
cd onig-5.9.2
./configure
make
make install
EOH
end
