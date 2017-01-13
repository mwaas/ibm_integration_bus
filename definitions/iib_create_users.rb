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
#################################################################################
# Definition IBM_Integration_Bus::iib_create_users
# 
# Create a user account for running IIB
#
################################################################################

define :iib_create_users do
  cdusername  = node['ibm_integration_bus']['cd_username'];
  mftusername = node['ibm_integration_bus']['mft_base_username'] + node['ibm_integration_bus']['cluster_num'];
  mqusername  = node['ibm_integration_bus']['mq_username'];
  sharedusername = node['ibm_integration_bus']['shared_username'];
  iibusername    = node['ibm_integration_bus']['account_username'];
  iibpassword    = node['ibm_integration_bus']['account_password'];
  home  = "/home/#{iibusername}"

  #
  # Install shadow ruby as chef requires this to handle passwords
  #
  if iibpassword
    gem_package "Install shadow ruby to support user name passwords" do
      package_name 'ruby-shadow'
      retries 30
      retry_delay 10
    end
  end

  user "Create user #{iibusername} to be used for administering IIB" do
    action :create
    shell '/bin/bash'
    home "/home/#{iibusername}"
    manage_home true
    username "#{iibusername}"
    if iibpassword
      password "#{iibpassword}"
    end
  end

  user "Create user #{cdusername} for Connect Direct" do
    action :create
    shell '/bin/bash'
    home "/home/#{cdusername}"
    manage_home true
    username "#{cdusername}"
  end

  user "Create user #{mqusername} for MQ" do
    action :create
    shell '/bin/bash'
    home "/home/#{mqusername}"
    manage_home true
    username "#{mqusername}"
  end

  user "Create user #{sharedusername} for MQ" do
    action :create
    shell '/bin/bash'
    home "/home/#{sharedusername}"
    manage_home true
    username "#{sharedusername}"
  end

  group "Create group #{iibusername} to be used for creating shared IIB resources" do
    group_name "#{iibusername}"
    members ["#{iibusername}", "#{mqusername}", "#{cdusername}"]
  end 

  group "Create group #{mqusername} to be used for creating shared MQ resources" do
    group_name "#{mqusername}"
    members ["#{iibusername}", "#{mqusername}", "#{cdusername}"]
  end 

  group "Create group #{cdusername} to be used for creating shared Connect Direct resources" do
    group_name "#{cdusername}"
    members ["#{iibusername}", "#{mqusername}", "#{cdusername}"]
  end 

  group "Create group #{sharedusername} to be used for creating shared resources" do
    group_name "#{sharedusername}"
    members ["#{iibusername}", "#{mqusername}", "#{cdusername}", "#{sharedusername}"]
  end 

  user "Create user #{mftusername} for Sterling MFT" do
    action :create
    shell '/bin/bash'
    home "/home/#{mftusername}"
    manage_home true
    username "#{mftusername}"
    gid "#{sharedusername}"
  end

  #
  # Ensure IIB user has a bash profile ready for any environment we need to configure
  #
  template "#{home}/.profile" do
    owner "#{iibusername}"
    group "#{iibusername}"
    mode "0770"
#    if File.exist?("#{home}/.profile") && File.size("#{home}/.profile") == 0
#      action :create
#    else
#      action :create_if_missing
#    end
    source 'IIBProfile.erb'
  end
end

