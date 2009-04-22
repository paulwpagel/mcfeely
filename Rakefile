require 'rubygems'

task :spec do
  gem 'rspec'
  require 'spec/rake/spectask'

  Spec::Rake::SpecTask.new(:spec){|t| t.spec_files = FileList['spec/props/**/*.rb']}
  Rake::Task[:spec].invoke
end