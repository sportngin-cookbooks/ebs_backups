class ::Chef::Resource::Cron
  include ::Opscode::EbsBackups::Helpers
end

define :cron_job, :cron => {}, :command => {} do
  cron params[:name] do
    action params[:cron][:action]
    minute params[:cron][:minute]
    hour params[:cron][:hour]
    day params[:cron][:day]
    weekday params[:cron][:weekday]
    month params[:cron][:month]
    mailto params[:cron][:mailto]
    user params[:cron][:user] || node[:ebs_backups][:user]
    path params[:cron][:path]
    shell params[:cron][:shell]
    provider params[:cron][:provider]
    command backup_command(params[:command])
  end
end
