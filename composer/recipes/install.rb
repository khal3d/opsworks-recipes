node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping composer::install application #{application} as it is not an PHP app")
    next
  end

  execute "install-composer-dependencies" do
    cwd deploy[:current_path]
    command "curl -s https://getcomposer.org/installer | php; php composer.phar install --no-dev --no-interaction --optimize-autoloader"
    only_if do
      File.exists?("#{deploy[:deploy_to]}/current/composer.json")
    end
  end
end