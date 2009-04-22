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

$PRODUCTION_PATH = File.expand_path(File.dirname(__FILE__) + "/../production")

require 'spec/mocks/framework'
class Module
  # cattr_accessor :prop_readers
  @@prop_readers = []
  
  def self.prop_readers
    @@prop_readers
  end
  
  def self.prop_readers=(value)
    @@prop_readers = value
  end
  
  def prop_reader(*symbols)
    @@prop_readers = [] unless @@prop_readers
    @@prop_readers.concat(symbols)
  end 
  
  def clear_prop_readers
    @@prop_readers = []
  end
end

def create_player(player_name, stubbed_mocks)
  player = Object.new.extend(player_name)
  if Module.prop_readers
    Module.prop_readers.each do |prop_reader|
      prop = mock(prop_reader, :text => "", :text= => nil, :value => "")
      action = lambda {return prop}

      player_name.send(:define_method, prop_reader, action)
    end
  end

  stubs = stubbed_mocks.map do |mock_name, mocked_options|
    stub = mock(mock_name.to_s)
    player.stub!(mock_name).and_return(stub)
    mocked_options.each_pair do |method, return_value|
      stub.stub!(method).and_return(return_value)
    end
    stub
  end
  return player, *stubs
end

