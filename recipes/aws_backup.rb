require File.expand_path("../../libraries/backup_command.rb", __FILE__)

user = node[:ebs_backups][:user]
group = node[:ebs_backups][:group]
home_dir = "/home/#{user}"

cookbook_file "automated-backup.sh" do
  path "#{home_dir}/automated-backup.sh"
  mode '0740'
  owner user
  group group
  action :create
end

node[:ebs_backups][:crons].each do |name, params|
  backup_user = params[:cron][:user] || node[:ebs_backups][:user]

  cron name do
    action params[:cron][:action]
    minute params[:cron][:minute]
    hour params[:cron][:hour]
    day params[:cron][:day]
    weekday params[:cron][:weekday]
    month params[:cron][:month]
    mailto params[:cron][:mailto]
    user backup_user
    path params[:cron][:path]
    shell params[:cron][:shell]
    provider params[:cron][:provider]
    command EbsBackups::BackupCommand.command(node, backup_user, params[:command])
  end
end
