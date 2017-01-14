################################################################################
# Definition IBM_Integration_Bus::iib_verify_installation
# 
# Verify IIB installation
#
################################################################################

define :iib_verify_installation do 
  install_dir = node['ibm_integration_bus']['install_dir'];
  iibusername = node['ibm_integration_bus']['account_username'];

  execute 'Verify IIB installation version' do
    user "#{iibusername}"
    command "#{install_dir}/iib-10.0.0.7/iib version"
    returns 0
  end

#  execute 'Verify IIB installation setup' do
#    user "#{iibusername}"
#    command "#{install_dir}/iib-10.0.0.7/server/bin/mqsilist"
#    returns 0
#  end

  execute 'Verify IIB installation setup' do
    user 'root'
    returns [0]
    command "sudo su - #{iibusername} -c \'mqsilist\'"
  end

end

