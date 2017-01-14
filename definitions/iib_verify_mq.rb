################################################################################
# Definition IBM_Integration_Bus::iib_verify_mq
# 
# Verify existing mq installation
#
################################################################################

define :iib_verify_mq do 
  execute 'Verify MQ 8 installation' do
    command '/opt/mq8/bin/dspmqver'
    returns 0
    ignore_failure true #TODO: remove after MQ is installed
  end

end

