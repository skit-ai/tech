require 'html-proofer'

task test: [:build] do
  options = { :assume_extension => true }
  HTMLProofer.check_directory('./_site', options).run
end

task :build do
  sh 'bundle exec jekyll build --trace'
end
