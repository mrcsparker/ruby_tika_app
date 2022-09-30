# frozen_string_literal: true

# Based on the rake remote task code

require 'rubygems'
require 'stringio'
require 'open4'

class RubyTikaApp
  TIKA_APP_VERSION = '1.24.1'

  class Error < RuntimeError; end

  class CommandFailedError < Error
    attr_reader :status
    def initialize(status)
      @status = status
    end
  end

  def initialize(document, config_path = nil)
    @document = if (document =~ %r{https?:\/\/[\S]+}) == 0
                  document
                else
                  "file://#{document}"
                end

    java_cmd = 'java'
    java_args = '-server -Djava.awt.headless=true -Dfile.encoding=UTF-8'
    ext_dir = File.join(File.dirname(__FILE__))
    tika_path = "#{ext_dir}/../ext/tika-app-#{TIKA_APP_VERSION}.jar"
    tika_config_path = config_path || "#{ext_dir}/../ext/tika-config.xml"

    @tika_cmd = "#{java_cmd} #{java_args} -jar '#{tika_path}' --config='#{tika_config_path}'"
  end

  def to_xml
    run_tika('--xml')
  end

  def to_html
    run_tika('--html')
  end

  def to_json(*_args)
    run_tika('--json')
  end

  def to_text
    run_tika('--text')
  end

  def to_text_main
    run_tika('--text-main')
  end

  def to_metadata
    run_tika('--metadata')
  end

  private

  def run_tika(option)
    final_cmd = "#{@tika_cmd} #{option} '#{@document}'"

    _, stdin, stdout, stderr = Open4.popen4(final_cmd)

    stdout_result = stdout.read.strip
    stderr_result = stderr.read.strip

    if stdout_result.empty? && !stderr_result.empty?
      raise(CommandFailedError.new(stderr_result),
            "execution failed with status #{stderr_result}: #{final_cmd}")
    end

    stdout_result
  ensure
    stdin.close
    stdout.close
    stderr.close
  end
end
