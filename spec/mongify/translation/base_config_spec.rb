require File.dirname(__FILE__) + '/../../spec_helper'

describe Mongify::Translation::BaseConfig do
  before(:each) do
    @base_config = Mongify::Translation::BaseConfig.new
  end
  it "should set any variable name that's passed" do
    @base_config = Mongify::Translation::BaseConfig.new(:apple => 'blue', :car => 'good')
    @base_config.instance_variables.should =~ ['@apple', '@car']
  end
  
  context "validation" do
    it "should be true" do
      @base_config.host 'localhost'
      puts @base_config.instance_methods.inspect
      @base_config.should be_valid
    end
    
    it "should be false" do
      @base_config.connection 'localhost'
      @base_config.should_not be_valid
    end
  end
  
  context "hash" do
    before(:each) do
      @adaptor = 'mysql'
      @host = '127.0.0.1'
      @database = 'test_database'
    end
    it "should give settings in a hash" do
      @sql_config = Mongify::Translation::BaseConfig.new(:adaptor => @adaptor, :host => @host, :database => @database)
      @sql_config.to_hash.should == {:adaptor => @adaptor, :host => @host, :database => @database}
    end
    it "should setup from constructor hash" do
      @sql_config = Mongify::Translation::BaseConfig.new(:adaptor => @adaptor, :host => @host, :database => @database)
      @sql_config.to_hash.should == {:adaptor => @adaptor, :host => @host, :database => @database}
    end
  end
end