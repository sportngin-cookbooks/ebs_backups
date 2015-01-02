require 'spec_helper'

describe file('/home/deploy/automated-backup.sh') do
  it { should be_file }
end

describe cron do
  it { should have_entry("1 * * * 6 /home/ec2-user/automated-backup.sh -t 'Backups,Values=true' -k 30").with_user('ec2-user') }
  it { should have_entry("2 * * * 6 land before time && /home/ec2-user/automated-backup.sh -t 'Before,Values=true' -k 30").with_user('ec2-user') }
  it { should have_entry("3 * * * 6 /home/ec2-user/automated-backup.sh -t 'After,Values=true' -k 30 && happily ever after").with_user('ec2-user') }
  it { should have_entry("4 * * * 6 /home/ec2-user/automated-backup.sh -t 'Failure,Values=true' -k 30 || epic fail").with_user('ec2-user') }
  it { should have_entry("5 * * * 6 land before time && /home/ec2-user/automated-backup.sh -t 'All,Values=true' -k 30 && happily ever after || epic fail &> /home/ec2-user/automated-backup").with_user('ec2-user') }
end
