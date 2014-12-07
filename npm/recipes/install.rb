node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping npm::install application #{application} as it is not an PHP app")
    next
  end

  execute "install-npm-dependencies" do
    cwd deploy[:current_path]
    command "npm install --unsafe-perm"
    only_if do
      File.exists?("#{deploy[:current_path]}/package.json")
    end
  end
end