require 'spec_helper'

describe user('ec2-user') do
  it { should exist }
  it { should belong_to_group 'ec2-user' }
  it { should have_home_directory '/home/ec2-user' }
end