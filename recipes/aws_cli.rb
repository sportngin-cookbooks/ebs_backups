user = node[:ebs_backups][:user]
group = node[:ebs_backups][:group]
home_dir = "/home/#{user}"

include_recipe "python"

python_pip "awscli" do 
  action :install
end

#Adding AWS directory, to store configs required for AWS CLI
directory "#{home_dir}/.aws" do
  owner user
  group group
  mode '0744'
  action :create
end

template "#{home_dir}/.aws/credentials" do
  source "credentials.erb"
  mode '0740'
  owner user
  group group
  variables :profiles => node[:ebs_backups][:aws][:profiles]
end

template "#{home_dir}/.aws/config" do
  source "config.erb"
  mode '0740'
  owner user
  group group
  variables :profiles => node[:ebs_backups][:aws][:profiles]
end
