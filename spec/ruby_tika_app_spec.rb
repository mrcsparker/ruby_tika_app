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
      }.to raise_error(RuntimeError)
    end
  end

  describe '#to_xml' do
    it 'header' do
      rta = RubyTikaApp.new(@test_file)
      expect(rta.to_xml[0..37]).to eq("<?xml version=\"1.0\" encoding=\"UTF-8\"?>")
    end

    it 'middle' do
      rta = RubyTikaApp.new(@test_file)
      xml = rta.to_xml

      xml_size = xml.size / 2

      expect(xml[xml_size..(xml_size + 100)]).to eq("d in Frontier Sampling (FS).\nSince this is the only difference between MHRW and USDSG,\nto be simple, ")
    end
  end

  describe '#to_html' do
    it 'header' do
      rta = RubyTikaApp.new(@test_file)
      expect(rta.to_html[0..42]).to eq("<html xmlns=\"http://www.w3.org/1999/xhtml\">")
    end

    it 'middle' do
      rta = RubyTikaApp.new(@test_file)
      expect(rta.to_html[1000 ... 1100]).to eq("Z\"/>\n<meta name=\"meta:save-date\" content=\"2011-03-29T13:00:16Z\"/>\n<meta name=\"pdf:encrypted\" content")
    end
  end

  describe '#to_json' do
    it 'header' do
      rta = RubyTikaApp.new(@test_file)
      expect(rta.to_json[0..42]).to eq("{\"Application\":\"\\u0027Certified by IEEE PDF")
    end

    it 'middle' do
      rta = RubyTikaApp.new(@test_file)
      expect(rta.to_json[100 ... 150]).to eq("\"171510\",\"Content-Type\":\"application/pdf\",\"Creatio")
    end
  end

  describe '#to_text' do
    it 'header' do
      rta = RubyTikaApp.new(@test_file)
      expect(rta.to_text[0..42]).to eq("Understanding Graph Sampling Algorithms\nfor")
    end

    it 'middle' do
      rta = RubyTikaApp.new(@test_file)
      expect(rta.to_text[100 ... 150]).to eq("in Zhang3, Tianyin Xu2\n\nLong Jin1, Pan Hui4, Beixi")
    end
  end

  describe '#to_text_main' do
    it 'header' do
      rta = RubyTikaApp.new(@test_file)
      expect(rta.to_text_main[0..42]).to eq('Understanding Graph Sampling Algorithms for')
    end

    it 'middle' do
      rta = RubyTikaApp.new(@test_file)
      expect(rta.to_text_main[100 ... 150]).to eq("n Zhang3, Tianyin Xu2\nLong Jin1, Pan Hui4, Beixing")
    end
  end

  describe '#to_metadata' do
    it 'header' do
      rta = RubyTikaApp.new(@test_file)
      expect(rta.to_metadata[0..42]).to eq("Application: 'Certified by IEEE PDFeXpress ")
    end

    it 'middle' do
      rta = RubyTikaApp.new(@test_file)
      expect(rta.to_metadata[100 ... 150]).to eq("Type: application/pdf\nCreation-Date: 2011-03-29T12")
    end
  end

  describe 'external URLs' do
    # TODO: Stub content from cnn.com
    it 'should be able to parse an http url' do
      rta = RubyTikaApp.new('https://cnn.com')
      expect(rta.to_text).to_not be_nil
    end

    # TODO: Stub content from news.ycombinator.com
    it 'should be able to parse another http url' do
      rta = RubyTikaApp.new('https://news.ycombinator.com')
      expect(rta.to_text).to_not be_nil
    end
  end
end
