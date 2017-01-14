################################################################################
# Definition IBM_Integration_Bus::iib_remove_runtime
# 
# Remove any existing iib runtime
#
################################################################################

define :iib_remove_runtime do
  install_dir = node['ibm_integration_bus']['install_dir'];

  directory "Remove IBM Integration Bus install directory #{install_dir} if it exists" do
    action :delete
    recursive true
    path "#{install_dir}"
  end

end

