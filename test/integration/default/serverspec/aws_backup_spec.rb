require 'spec_helper'

describe file('/home/deploy/automated-backup.sh') do
  it { should be_file }
end

# describe cron do
#   it { should have_entry("1 * * * 6 /home/deploy/ec2-automate-backup-awscli.sh -t 'Backups=true' -k 30") }
# end
# Serverspec cron matcher is not working at the moment