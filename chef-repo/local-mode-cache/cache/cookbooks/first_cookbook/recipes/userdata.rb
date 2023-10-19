file "/home/ec2-user/userdata.txt" do
  content "Hello, this is my userdata cookbook recipe\n"
  action :create
end

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

# Wait for /dev/sdf to be available
execute "wait_for_dev_sdf" do
  cwd "/tmp"
  command <<-EOH
    while [[ ! -b $(readlink -f /dev/sdf) ]]; do
      echo 'waiting for /dev/sdf'
      sleep 2
    done
  EOH
end


execute "format_dev_sdf" do
  cwd "/tmp"
  command <<-EOH
    if ! file -s $(readlink -f /dev/sdf) | grep 'ext4'; then
      mkfs.ext4 $(readlink -f /dev/sdf)
      e2label $(readlink -f /dev/sdf) ec2-user-workdir
    fi
    wait
  EOH
end

directory '/opt/clevertap' do
  owner "ec2-user"
  group "ec2-user"
  mode '0755'
  recursive true
  action :create
end

mount '/opt/clevertap' do
  device '/dev/sdf'
  fstype 'ext4'
  options 'defaults,nofail,rw'
  action [:mount, :enable]
end

directory "/opt/clevertap" do
  owner "ec2-user"
  group "ec2-user"
  mode "0755"
  recursive true
  action :create
end

execute "check_fstab_entry" do
  cwd "/tmp"
  command <<-EOH
    if ! cat /etc/fstab | grep "bamboo-home"
    then
        echo "LABEL=ec2-user-workdir /opt/clevertap ext4 defaults,nofail 0 2" >> /etc/fstab
    fi
  EOH
end
