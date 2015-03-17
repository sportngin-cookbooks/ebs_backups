user = node[:ebs_backups][:user]
group = node[:ebs_backups][:group]
home_dir = "/home/#{user}"


user user do
  home home_dir
  system true
  supports :manage_home => true
end

group group do
  members user
  append true
end

directory node[:ebs_backups][:log_dir] do
  owner user
  group group
  mode '0755'
end
