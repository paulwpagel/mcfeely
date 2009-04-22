def add_to_search_path path
  $: << File.expand_path(File.dirname(__FILE__) + "/../../#{path}")
end

[
  "production/main",
  "production/players",
  "production",
  "production/lib",
].each {|path| add_to_search_path path}

require 'rubygems'
require 'spec'
require 'limelight/specs/spec_helper'

$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../../production")
