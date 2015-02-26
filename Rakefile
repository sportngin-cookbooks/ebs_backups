task default: %w[test]

desc("Run all test kitchen integration tests.")
task :test do
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
  Rake::Task['kitchen:all'].invoke
end