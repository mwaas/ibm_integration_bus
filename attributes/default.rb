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

default['ibm_integration_bus']['package_site_url'] = 'file:///data/mwaas/ibm_images/iib'
default['ibm_integration_bus']['package_name']     = '10.0.0.7-IIB-LINUX64-DEVELOPER.tar.gz'
default['ibm_integration_bus']['install_dir']      = '/gif/app/mqsi'
default['ibm_integration_bus']['cluster_num']      = '1'
default['ibm_integration_bus']['nas_base_mount']   = '/nasfs/mcl'
default['ibm_integration_bus']['cd_username']      = 'cdadmin'
default['ibm_integration_bus']['mft_base_username'] = 'FiibCL'
default['ibm_integration_bus']['mq_username']      = 'mqm'
default['ibm_integration_bus']['shared_username']  = 'mqdev'
default['ibm_integration_bus']['broker_username']  = 'mqbrkrs'
default['ibm_integration_bus']['account_username'] = 'iib'
default['ibm_integration_bus']['account_password'] = nil
default['ibm_integration_bus']['iib_nodes']        = nil
default['ibm_integration_bus']['clean_install']    = false

