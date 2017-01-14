#################################################################################
# Definition IBM_Integration_Bus::iib_create_directories
# 
# Create directories to contain shared resources
#
################################################################################

define :iib_create_directories do
  cdusername  = node['ibm_integration_bus']['cd_username'];
  mftusername = node['ibm_integration_bus']['mft_base_username'] + node['ibm_integration_bus']['cluster_num'];
  mqusername  = node['ibm_integration_bus']['mq_username'];
  sharedusername = node['ibm_integration_bus']['shared_username'];
  brokerusername = node['ibm_integration_bus']['broker_username'];
  iibusername    = node['ibm_integration_bus']['account_username'];
  nasmount       = node['ibm_integration_bus']['nas_base_mount'] + node['ibm_integration_bus']['cluster_num'];

  directory '/gif' do
    owner  "#{iibusername}"
    group "#{sharedusername}"
    mode '0770'
    action :create
  end 

  directory '/gif/app' do
    owner  "#{iibusername}"
    group "#{iibusername}"
    mode '0770'
    action :create
  end 

  directory '/gif/app/mqsi' do
    owner  "#{iibusername}"
    group "#{iibusername}"
    mode '0770'
    action :create
  end 

  directory '/gif/app/IE02' do
    owner  "#{iibusername}"
    group "#{iibusername}"
    mode '0770'
    action :create
  end 

  directory '/gif/app/itx' do
    owner  "#{iibusername}"
    group "#{iibusername}"
    mode '0770'
    action :create
  end 

  directory '/gif/data' do
    owner  "#{iibusername}"
    group "#{iibusername}"
    mode '0770'
    action :create
  end 

  directory '/gif/data/mqsi' do
    owner  'root'
    group "#{brokerusername}"
    mode '0775'
    action :create
  end 

  directory '/gif/proj' do
    owner  "#{iibusername}"
    group "#{sharedusername}"
    mode '0770'
    action :create
  end 

  directory '/opt/ibm' do
    owner  "#{iibusername}"
    group "#{iibusername}"
    mode '0770'
    action :create
  end 

  execute "Verify NAS mount #{nasmount}" do
    command "ls #{nasmount}"
    returns 0
  end

  link '/opt/ibm/mqsi' do
    to '/gif/app/mqsi'
    owner  "#{iibusername}"
    group "#{iibusername}"
    mode '0770'
  end

  link '/opt/ibm/IE02' do
    to '/gif/app/IE02'
    owner  "#{iibusername}"
    group "#{iibusername}"
    mode '0770'
  end

  link '/opt/ibm/itx' do
    to '/gif/app/itx'
    owner  "#{iibusername}"
    group "#{iibusername}"
    mode '0770'
  end

  link '/var/mqsi' do
    to '/gif/data/mqsi'
    owner  "#{iibusername}"
    group "#{iibusername}"
    mode '0770'
  end

  link '/gif/proj/IIBdata' do
    to "#{nasmount}"
    owner  "#{iibusername}"
    group "#{sharedusername}"
    mode '0770'
  end

end

