module EbsBackups
  class BackupCommand
    def self.command(node, user, params)
      new(node, user, params).command
    end

    def initialize(node, user, params)
      @node = node
      @params = params
      @user = user
    end

    def command
      ['(', before_command, "/home/#{@user}/automated-backup.sh#{backup_options}", after_command, failure_command, ')', log].compact.join(" ")
    end

    def before_command
      "#{@params[:before]} &&" if @params[:before]
    end

    def after_command
      "&& #{@params[:after]}" if @params[:after]
    end

    def failure_command
      "|| #{@params[:failure]}" if @params[:failure]
    end

    def log
      ">> #{logfile} 2>&1" if @params[:log]
    end

    def logfile
      @params[:logfile] || "#{@node[:ebs_backups][:log_dir]}/ebs_backups.log"
    end

    def backup_options
      options = ""
      options << %Q{ -s #{@params[:selection_method]}} if @params[:selection_method]
      options << %Q{ -t "#{@params[:tag]},Values=#{@params[:tag_value] ? @params[:tag_value] : 'true' }"} if @params[:tag]
      options << %Q{ -v #{@params[:volumeid]}} if @params[:volumeid]
      options << %Q{ -r #{@params[:region]}} if @params[:region]
      options << %Q{ -c #{@params[:cron_primer_file]}} if @params[:cron_primer_file]
      options << %Q{ -k #{@params[:purge_after_days]}} if @params[:purge_after_days]
      options << %Q{ -p}if @params[:purge]
      options << %Q{ -a "#{@params[:permitted_account_ids]}"} if @params[:permitted_account_ids]
      options
    end
  end
end
