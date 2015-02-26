task default: %w[lint test]

desc("Log and fail the build on correctness.")
task :lint do
  require 'foodcritic'
  FoodCritic::Rake::LintTask.new do |t|
    t.options = {
        fail_tags: ['correctness'],
        tags: ['correctness ~FC001']
    }
  end
  Rake::Task['foodcritic'].invoke
end

desc("Run all test kitchen integration tests.")
task :test do
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
  Rake::Task['kitchen:all'].invoke
end