user = node[:ebs_backups][:user]
group = node[:ebs_backups][:group]
home_dir = "/home/#{user}"

group group
user user do
  home home_dir
  gid group
  system true
  supports :manage_home => true
end

directory node[:ebs_backups][:log_dir] do
  owner user
  group group
  mode '0755'
end
