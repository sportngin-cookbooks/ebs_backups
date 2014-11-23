user = node[:ebs_backups][:user]
group = node[:ebs_backups][:group]
home_dir = "/home/#{user}"

cookbook_file "automated-backup.sh" do
  path "#{home_dir}/automated-backup.sh"
  mode '0640'
  owner user
  group group
  action :create
end

node[:ebs_backups][:crons].each do |name, params|
  cron_job name do 
    cron params[:cron]
    command params[:command]
  end
end
