node[:deploy].each do |application, deploy|
  execute "node-softlink" do
    command "ln -s \"$(which nodejs)\" /usr/bin/node"
    user "root"
  end
end
