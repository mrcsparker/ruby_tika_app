require 'spec_helper'

describe RubyTikaApp do
  let(:doc_path)  { "#{File.join(File.dirname(__FILE__))}/docs" }
  let(:test_file) { "#{doc_path}/graph sampling simplex - 11.pdf" }
  let(:cnn_com_file) { "#{doc_path}/cnn.com" }
  let(:news_ycombinator_com_file) { "#{doc_path}/news.ycombinator.com" }
  let(:rta) { RubyTikaApp.new(test_file) }

  describe 'Error' do
    let(:rta) { RubyTikaApp.new('No file') }

    specify { expect { rta.to_xml  }.to raise_error } 
  end

  describe '#to_xml' do
    it 'header' do  
      rta.to_xml[0..37].should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    end

    it "middle" do
      xml = rta.to_xml
      xml_size = xml.size / 2
      xml[xml_size..(xml_size + 100)].should == "S (Section IV). Besides,\nMHRW performs better in well connected graphs than in\nloosely connected grap"
    end
  end

  describe '#to_html' do
    it 'header' do
      rta.to_html[0..42].should == "<html xmlns=\"http://www.w3.org/1999/xhtml\">"
    end

    it 'middle' do
      rta.to_html[1000 ... 1100].should == "rceName\" content=\"graph sampling simplex - 11.pdf\"/>\n<meta name=\"Last-Save-Date\" content=\"2011-03-29"
    end
  end

  describe '#to_json' do
    it 'header' do
      rta.to_json[0..42].should == "{ \"Application\":\"\\u0027Certified by IEEE PD"
    end

    it 'middle' do
      rta.to_json[100 ... 150].should == "h\":171510, \n\"Content-Type\":\"application/pdf\", \n\"Cr"
    end
  end

  describe '#to_text' do
    it 'header' do
      rta.to_text[0..42].should == "Understanding Graph Sampling Algorithms\nfor"
    end

    it 'middle' do
      rta.to_text[100 ... 150].should == "n Zhang3, Tianyin Xu2\n\nLong Jin1, Pan Hui4, Beixin"
    end
  end

  describe '#to_text_main' do
    it 'header' do
      rta.to_text_main[0..42].should == 'Understanding Graph Sampling Algorithms for'
    end

    it 'middle' do
      rta.to_text_main[100 ... 150].should == "n Zhang3, Tianyin Xu2\nLong Jin1, Pan Hui4, Beixing"
    end
  end

  describe '#to_metadata' do
    it 'header' do
      rta.to_metadata[0..42].should == "Application: 'Certified by IEEE PDFeXpress "
    end

    it 'middle' do
      rta.to_metadata[100 ... 150].should == "Type: application/pdf\nCreation-Date: 2011-03-29T12"
    end
  end

  describe 'external URLs' do
    let(:rta) { RubyTikaApp.new(url) }

    context "cnn.com" do
      let(:url) { 'http://localhost:9299/cnn.com' }
      
      it { rta.to_text.should include "SET EDITION" }
    end

    context "news.ycombinator.com" do
      let(:url) { 'http://localhost:9299/news.ycombinator.com' }

      it { rta.to_text.should include "Hacker News" }
    end
  end

end
