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
    it "header" do
      rta = RubyTikaApp.new(@test_file)
      rta.to_json[0..42].should == "{ \"Application\":\"\\u0027Certified by IEEE PD"
    end

    it "middle" do
      rta = RubyTikaApp.new(@test_file)
      rta.to_json[100 ... 150].should == "h\":171510, \n\"Content-Type\":\"application/pdf\", \n\"Cr"
    end
  end

  describe "#to_text" do
    it "header" do
      rta = RubyTikaApp.new(@test_file)
      rta.to_text[0..42].should == "Understanding Graph Sampling Algorithms\nfor"
    end

    it "middle" do
      rta = RubyTikaApp.new(@test_file)
      rta.to_text[100 ... 150].should == "n Zhang3, Tianyin Xu2\nLong Jin1, Pan Hui4, Beixing"
    end
  end

  describe "#to_text_main" do
    it "header" do
      rta = RubyTikaApp.new(@test_file)
      rta.to_text_main[0..42].should == "Understanding Graph Sampling Algorithms for"
    end

    it "middle" do
      rta = RubyTikaApp.new(@test_file)
      rta.to_text_main[100 ... 150].should == "n Zhang3, Tianyin Xu2 Long Jin1, Pan Hui4, Beixing"
    end
  end

  describe "#to_metadata" do
    it "header" do
      rta = RubyTikaApp.new(@test_file)
      rta.to_metadata[0..42].should == "Application: 'Certified by IEEE PDFeXpress "
    end

    it "middle" do
      rta = RubyTikaApp.new(@test_file)
      rta.to_metadata[100 ... 150].should == "Type: application/pdf\nCreation-Date: 2011-03-29T12"
    end

  end

end
