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
# Definition IBM_Integration_Bus::iib_verify_mq
# 
# Verify existing mq installation
#
################################################################################

define :iib_verify_mq do 
  execute 'Verify MQ 8 installation' do
    command '/opt/mq8/bin/dspmqver'
    returns 0
  end

end

