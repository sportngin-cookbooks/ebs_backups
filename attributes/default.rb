default[:ebs_backups][:user] = 'deploy'
default[:ebs_backups][:group] = 'deploy'

default[:ebs_backups][:sudo] = false

default[:ebs_backups][:log_dir] = '/var/log/ebs_backups'

default[:ebs_backups][:aws][:profiles] = {}

default[:ebs_backups][:crons] = {}
