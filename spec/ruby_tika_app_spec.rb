require 'spec_helper'

describe RubyTikaApp do

  before(:each) do
    doc_path = "#{File.join(File.dirname(__FILE__))}/docs"
    
    @test_file = "#{doc_path}/graph sampling simplex - 11.pdf"

    @cnn_com_file = "#{doc_path}/cnn.com"
    @news_ycombinator_com_file = "#{doc_path}/news.ycombinator.com"
  end

  describe 'Error' do
    it 'has an error' do
      expect {
        rta = RubyTikaApp.new('No file')
        rta.to_xml
      }.to raise_error
    end
  end

  describe '#to_xml' do
    it 'header' do
      rta = RubyTikaApp.new(@test_file)
      rta.to_xml[0..37].should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    end
  
    it 'middle' do
      rta = RubyTikaApp.new(@test_file)
      xml = rta.to_xml

      xml_size = xml.size / 2

      xml[xml_size..(xml_size + 100)].should == "ction IV). Besides,\nMHRW performs better in well connected graphs than in\nloosely connected graphs, a"
    end
  end

  describe '#to_html' do
    it 'header' do
      rta = RubyTikaApp.new(@test_file)
      rta.to_html[0..42].should == "<html xmlns=\"http://www.w3.org/1999/xhtml\">"
    end

    it 'middle' do
      rta = RubyTikaApp.new(@test_file)
      rta.to_html[1000 ... 1100].should == "rceName\" content=\"graph sampling simplex - 11.pdf\"/>\n<meta name=\"Last-Save-Date\" content=\"2011-03-29"
    end
  end

  describe '#to_json' do
    it 'header' do
      rta = RubyTikaApp.new(@test_file)
      rta.to_json[0..42].should == "{ \"Application\":\"\\u0027Certified by IEEE PD"
    end

    it 'middle' do
      rta = RubyTikaApp.new(@test_file)
      rta.to_json[100 ... 150].should == "h\":171510, \n\"Content-Type\":\"application/pdf\", \n\"Cr"
    end
  end

  describe '#to_text' do
    it 'header' do
      rta = RubyTikaApp.new(@test_file)
      rta.to_text[0..42].should == "Understanding Graph Sampling Algorithms\nfor"
    end

    it 'middle' do
      rta = RubyTikaApp.new(@test_file)
      rta.to_text[100 ... 150].should == "n Zhang3, Tianyin Xu2\n\nLong Jin1, Pan Hui4, Beixin"
    end
  end

  describe '#to_text_main' do
    it 'header' do
      rta = RubyTikaApp.new(@test_file)
      rta.to_text_main[0..42].should == 'Understanding Graph Sampling Algorithms for'
    end

    it 'middle' do
      rta = RubyTikaApp.new(@test_file)
      rta.to_text_main[100 ... 150].should == "n Zhang3, Tianyin Xu2\nLong Jin1, Pan Hui4, Beixing"
    end
  end

  describe '#to_metadata' do
    it 'header' do
      rta = RubyTikaApp.new(@test_file)
      rta.to_metadata[0..42].should == "Application: 'Certified by IEEE PDFeXpress "
    end

    it 'middle' do
      rta = RubyTikaApp.new(@test_file)
      rta.to_metadata[100 ... 150].should == "Type: application/pdf\nCreation-Date: 2011-03-29T12"
    end
  end

  describe 'external URLs' do
    it 'should be able to parse an http url' do
      rta = RubyTikaApp.new('http://localhost:9299/cnn.com')
      rta.to_text.should_not be_nil
      rta.to_text.should eq(RubyTikaApp.new(@cnn_com_file).to_text)
    end

    it 'should be able to parse another http url' do
      rta = RubyTikaApp.new('http://localhost:9299/news.ycombinator.com')
      rta.to_text.should_not be_nil
      rta.to_text.should eq(RubyTikaApp.new(@news_ycombinator_com_file).to_text)
    end
  end

end
