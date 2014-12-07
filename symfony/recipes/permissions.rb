node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping symfony::permissions application #{application} as it is not an PHP app")
    next
  end

  execute 'symfony-directory-permission' do
    action :run
    user 'root'
    command "
      chmod 775 -R #{deploy[:current_path]}/app/cache/
      chmod 775 -R #{deploy[:current_path]}/app/logs/
      chmod 775 -R #{deploy[:current_path]}/web/
      chown -R #{deploy[:group]}:www-data #{deploy[:current_path]}
    "
  end
  
end