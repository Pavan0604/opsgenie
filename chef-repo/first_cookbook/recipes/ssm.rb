remote_file "/tmp/amazon-ssm-agent.rpm" do
  source "https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm"
  action :create
end

package "amazon-ssm-agent" do
  source "/tmp/amazon-ssm-agent.rpm"
  action :install
end


service "amazon-ssm-agent" do
  action [ :enable, :start ]
end
