################################################################################
# Definition IBM_Integration_Bus::iib_install_package
# 
# Unpack and setup the iib instal package
#
################################################################################

define :iib_install_package do
  package_site_url   = node['ibm_integration_bus']['package_site_url'];
  package_name       = node['ibm_integration_bus']['package_name'];
  package_url        = "#{package_site_url}/#{package_name}"; 
  download_path      = "#{Chef::Config[:file_cache_path]}/#{package_name}"; 
  install_dir        = node['ibm_integration_bus']['install_dir'];
  iibusername        = node['ibm_integration_bus']['account_username'];
  
  remote_file "Download the install image package from #{package_url} into #{download_path}"  do
    owner "#{iibusername}"
    group "#{iibusername}"
    path "#{download_path}"
    source "#{package_url}"
    retries 30
    retry_delay 10
    if File.exist?("#{download_path}") && File.size("#{download_path}") == 0
      action :create
    else
      action :create_if_missing
    end
  end
  
  ruby_block "Verify downloaded install image package in #{download_path}" do
    action :run
    block do
      if File.exist?("#{download_path}") && File.size("#{download_path}") == 0
        raise "Downloaded install package is invalid. Check that URL #{package_url} is correct"
      end
    end
  end
  
  if File.exist?("#{install_dir}/iib-10.0.0.7/")
    log "Skipping unpacking of runtime image into #{install_dir}" do
      level :info
    end
  else
    execute "Unpack runtime image into #{install_dir}" do
      user "#{iibusername}"
      group "#{iibusername}"
      command "tar -xzf #{download_path} -C #{install_dir}"
    end
  end
  
  execute "Install IIB in silent mode as root" do
    user 'root'
    command "#{install_dir}/iib-10.0.0.7/iib make registry global accept license silently"
  end
  
  execute "Change all file and directory ownership recursively for #{install_dir}/iib-10.0.0.7" do
    user 'root'
    command "chown -R #{iibusername}:#{iibusername} #{install_dir}/iib-10.0.0.7"
  end

end

