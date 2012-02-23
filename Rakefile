require 'rubygems'
require 'xcodebuild'

class KiwiFormatter

end

XcodeBuild::Tasks::BuildTask.new do |t|
  t.workspace = "MagicalFactory.xcworkspace"
  t.scheme = "Specs"
  # t.formatter = XcodeBuild::Formatters::ProgressFormatter.new
  t.formatter = KiwiFormatter.new
end
