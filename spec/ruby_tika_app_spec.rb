require 'spec_helper'

describe RubyTikaApp do

  before(:each) do
    @test_file = "#{File.join(File.dirname(__FILE__))}/docs/graph_sampling_simplex11.pdf"
  end

  describe "#to_xml" do
    it "header" do
      rta = RubyTikaApp.new(@test_file)
      rta.to_xml[0..37].should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    end
  
    it "middle" do
      rta = RubyTikaApp.new(@test_file)
      xml = rta.to_xml

      xml_size = xml.size / 2

      xml[xml_size..(xml_size + 100)].should == "HRW considers all the duplicated nodes as valid nodes.\nThese duplicated nodes make the node distribut"
    end
  end

  describe "#to_html" do
    it "header" do
      rta = RubyTikaApp.new(@test_file)
      rta.to_html[0..42].should == "<html xmlns=\"http://www.w3.org/1999/xhtml\">"
    end

    it "middle" do
      rta = RubyTikaApp.new(@test_file)
      rta.to_html[1000 ... 1100].should == "ersity of Goettingen, Germany\n3 Department of Computer Science, U.C. Santa Barbara, USA\n4 Deutsche T"
    end
  end

  describe "#to_json" do

  end

  describe "#to_text" do

  end

  describe "#to_text_main" do

  end

  describe "#to_metadata" do

  end

end
