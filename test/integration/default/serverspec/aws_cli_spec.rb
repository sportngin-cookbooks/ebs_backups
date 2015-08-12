require 'spec_helper'

describe command('/usr/local/bin/pip list') do
  its(:stdout) { should match /awscli/ }
end

describe file('/home/ec2-user/.aws') do
  it { should be_directory }
end

describe file('/home/ec2-user/.aws/config') do
  it { should be_file }
  it { should be_grouped_into 'ec2-user' }
  it { should be_owned_by 'ec2-user'}
  it { should contain '[default]', '[user1]' }
  it { should contain 'REGION_1', 'OUTPUT_1' }
  it { should contain 'REGION_1', 'OUTPUT_2' }
end

describe file('/home/ec2-user/.aws/credentials') do
  it { should be_file }
  it { should be_grouped_into 'ec2-user' }
  it { should be_owned_by 'ec2-user'}
  it { should contain '[default]', '[user1]' }
  it { should contain 'EXAMPLE_KEY_1', 'EXAMPLE_SECRET_1' }
  it { should contain 'EXAMPLE_KEY_2', 'EXAMPLE_SECRET_2' }
end
