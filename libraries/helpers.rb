module EbsBackups
  module Helpers
    def backup_command(params)
      command = ["/home/#{user}/automated-backup.sh"]
      if params[:selection_method]
        command << "-s #{params[:selection_method]}"
      end
      if params[:tag]
        command << "-t '#{params[:tag]},Values=true'"
      end
      if params[:volumeid]
        command << "-v '#{params[:volumeid]}'"
      end
      if params[:region]
        command << "-r #{params[:region]}"
      end
      if params[:cron_primer_file]
        command << "-c #{params[:cron_primer_file]}"
      end
      if params[:purge_after_days]
        command << "-k #{params[:purge_after_days]}"
      end
      if params[:purge]
        command << "-p"
      end
      if params[:log]
      "> /home/#{user}/automated-backup_`date +\"%Y%m%d\"`.log"
      end
      command * " "
    end
  end
end
