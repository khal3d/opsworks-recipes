node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping php::set-timezone application #{application} as it is not an PHP app")
    next
  end

  include_recipe "apache2::service"

  execute "Setup PHP default timezone" do
    command "sed -i 's/;date\.timezone.*/date.timezone = UTC/g' `php -r 'echo php_ini_loaded_file();'`"
    user "root"
    notifies :reload, resources(:service => "apache2"), :delayed
  end
end
