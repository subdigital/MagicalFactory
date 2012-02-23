require 'rubygems'
require 'xcodebuild'

task :default => ["xcode:clean", "xcode:build"]

XcodeBuild::Tasks::BuildTask.new do |t|
  t.workspace = "MagicalFactory.xcworkspace"
  t.scheme = "Specs"
  t.configuration = "Debug"
  t.sdk = "iphonesimulator5.0"
  t.formatter = XcodeBuild::Formatters::ProgressFormatter.new
end
