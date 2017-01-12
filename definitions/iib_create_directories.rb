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
# Definition IBM_Integration_Bus::iib_create_directories
# 
# Create directories to contain shared resources
#
################################################################################

define :iib_create_directories do
  cdusername  = node['ibm_integration_bus']['cd_username'];
  mftusername = node['ibm_integration_bus']['mft_username'];
  mqusername  = node['ibm_integration_bus']['mq_username'];
  sharedusername = node['ibm_integration_bus']['shared_username'];
  iibusername    = node['ibm_integration_bus']['account_username'];

  directory '/gif' do
    owner  "#{iibusername}"
    group "#{sharedusername}"
    mode '0770'
    action :create
  end 

  directory '/gif/app/mqsi' do
    owner  "#{iibusername}"
    group "#{sharedusername}"
    mode '0770'
    action :create
  end 

  directory '/gif/app/IE02' do
    owner  "#{iibusername}"
    group "#{sharedusername}"
    mode '0770'
    action :create
  end 

  directory '/gif/app/itx' do
    owner  "#{iibusername}"
    group "#{sharedusername}"
    mode '0770'
    action :create
  end 

  directory '/gif/data/mqsi' do
    owner  "#{iibusername}"
    group "#{sharedusername}"
    mode '0770'
    action :create
  end 

  directory '/gif/proj' do
    owner  "#{iibusername}"
    group "#{sharedusername}"
    mode '0770'
    action :create
  end 

  directory '/nasfs/mcl1' do
    owner  "#{iibusername}"
    group "#{sharedusername}"
    mode '0770'
    action :create
  end 

  execute 'Verify NAS mount' do
    command 'ls /nasfs/mcl1'
    returns 0
  end

  link '/opt/ibm/mqsi' do
    to '/gif/app/mqsi'
  end

  link '/opt/ibm/IE02' do
    to '/gif/app/IE02'
  end

  link '/opt/ibm/itx' do
    to '/gif/app/itx'
  end

  link '/var/mqsi' do
    to '/gif/data/mqsi'
  end

  link '/gif/proj/IIBdata' do
    to '/nasfs/mcl1'
  end

end

