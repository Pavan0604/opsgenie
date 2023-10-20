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
