module EbsBackups
  class BackupCommand
    def self.command(user, params)
      new(user, params).command
    end

    def initialize(user, params)
      @params = params
      @user = user
    end

    def command
      [before_command, "/home/#{@user}/automated-backup.sh#{backup_options}", after_command, failure_command, log].compact.join(" ")
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
      @params[:logfile] || "/var/log/ebs_backups.log"
    end

    def backup_options
      options = ""
      options << " -s #{@params[:selection_method]}" if @params[:selection_method]
      options << " -t '#{@params[:tag]},Values=true'" if @params[:tag]
      options << " -v '#{@params[:volumeid]}'" if @params[:volumeid]
      options << " -r #{@params[:region]}" if @params[:region]
      options << " -c #{@params[:cron_primer_file]}" if @params[:cron_primer_file]
      options << " -k #{@params[:purge_after_days]}" if @params[:purge_after_days]
      options << " -p" if @params[:purge]
      options
    end
  end
end
