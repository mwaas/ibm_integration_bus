################################################################################
#
# Copyright (c) 2013 IBM Corporation and other Contributors
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
# Contributors:
#     IBM - initial implementation
#
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
#        unpack_dir         = "#{Chef::Config[:file_cache_path]}/iib_installer";
        unpack_dir         = node['ibm_integration_bus']['install_dir'];
        iibusername        = node['ibm_integration_bus']['account_username'];

	directory "Remove unpacked runtime image if it exists" do
	  action :delete
	  recursive true
	  path "#{unpack_dir}"
	end

	directory "Create directory to unpacked runtime to: #{unpack_dir }" do
	  user "#{iibusername}"
	  group "#{iibusername}"
           mode '0770'
	  action :create
	  recursive true
	  path "#{unpack_dir}"
	end 

        log "#{:package_url}" do
          level :info
        end

	remote_file "Download the install image package from: #{package_url} to: #{download_path}"  do
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

	ruby_block "Checking the downloaded install image package from: #{download_path} has content" do
	  action :run
	  block do
	    if File.exist?("#{download_path}") && File.size("#{download_path}") == 0
	      raise "Downloaded install package is invalid. Check the URL #{package_url} is correct"
	    end
	  end
	end

	execute "Unpack runtime image into #{unpack_dir} as #{iibusername}" do
	  user "#{iibusername}"
	  group "#{iibusername}"
	  command "tar -xzf #{download_path} -C #{unpack_dir}"
	end

	execute "Install IIB in silent mode as root" do
          user 'root'
	  command "#{unpack_dir}/iib-10.0.0.7/iib make registry global accept license silently"
	end

        execute "Change all file and directory ownership recursively for #{unpack_dir}/iib-10.0.0.7" do
          user 'root'
	  command "chown -R #{iibusername}:#{iibusername} #{unpack_dir}/iib-10.0.0.7"
        end

end

