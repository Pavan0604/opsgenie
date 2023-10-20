#
# Cookbook:: first_cookbook
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.
#
#

file "/home/ec2-user/default.txt" do
  content "Hello, this is my first cookbook recipe\n"
  action :create
end


include_recipe 'first_cookbook::ssm'
include_recipe 'first_cookbook::persistent_storage'
include_recipe 'first_cookbook::crontab'
