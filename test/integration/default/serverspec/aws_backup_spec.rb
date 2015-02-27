require 'spec_helper'

describe file('/home/ec2-user/automated-backup.sh') do
  it { should be_file }
end

describe cron do
  it { should have_entry(%Q{1 * * * 6 /home/ec2-user/automated-backup.sh -t "Backups,Values=true" -k 30}).with_user('ec2-user') }
  it { should have_entry(%Q{2 * * * 6 land before time && /home/ec2-user/automated-backup.sh -t "Before,Values=true" -k 30}).with_user('ec2-user') }
  it { should have_entry(%Q{3 * * * 6 /home/ec2-user/automated-backup.sh -t "After,Values=true" -k 30 && happily ever after}).with_user('ec2-user') }
  it { should have_entry(%Q{4 * * * 6 /home/ec2-user/automated-backup.sh -t "Failure,Values=true" -k 30 || epic fail}).with_user('ec2-user') }
  it { should have_entry(%Q{5 * * * 6 land before time && /home/ec2-user/automated-backup.sh -t "All,Values=true" -k 30 && happily ever after || epic fail >> /var/log/ebs_backups/ebs_backups.log 2>&1}).with_user('ec2-user') }
  it { should have_entry(%Q{1 * * * 6 /home/ec2-user/automated-backup.sh -t "Backups,Values=true" -a "1234"}).with_user('ec2-user') }
  it { should have_entry(%Q{1 * * * 6 /home/ec2-user/automated-backup.sh -t "Backups,Values=true" -a "1234 5678"}).with_user('ec2-user') }
end
