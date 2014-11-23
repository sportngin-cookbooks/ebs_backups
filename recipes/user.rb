user = node[:ebs_backups][:user]
group = node[:ebs_backups][:group]

home_dir = "/home/#{user}"

user user do
  home home_dir
  system true
end

group group do
  members user
end

directory home_dir do
  owner user
  group group
  mode 0700
end
