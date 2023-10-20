#
# Cookbook:: first_cookbook
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.
#

include_recipe 'first_cookbook::ssm'
include_recipe 'first_cookbook::persistent_storage'
include_recipe 'first_cookbook::crontab'
