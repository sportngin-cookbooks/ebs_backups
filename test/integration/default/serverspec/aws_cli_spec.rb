require 'spec_helper'

describe package('aws') do
  it { should be_installed.by('pip') }
end

describe file('/home/deploy/.aws') do
  it { should be_directory }
end

describe file('/home/deploy/.aws/config') do
  it { should be_file }
  it { should be_grouped_into 'deploy' }
  it { should be_owned_by 'deploy'}
  it { should contain '[default]', '[user1]' }
  it { should contain 'REGION_1', 'OUTPUT_1' }
  it { should contain 'REGION_1', 'OUTPUT_2' }
end

describe file('/home/deploy/.aws/credentials') do
  it { should be_file }
  it { should be_grouped_into 'deploy' }
  it { should be_owned_by 'deploy'}
  it { should contain '[default]', '[user1]' }
  it { should contain 'EXAMPLE_KEY_1', 'EXAMPLE_SECRET_1' }
  it { should contain 'EXAMPLE_KEY_2', 'EXAMPLE_SECRET_2' }
end