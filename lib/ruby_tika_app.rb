# Based on the rake remote task code

require 'rubygems'
require 'stringio'
require 'open4'

class RubyTikaApp

  class Error < RuntimeError; end

  class CommandFailedError < Error
    attr_reader :status
    def initialize(status)
      @status = status
    end
  end

  def initialize(document)
    if (document =~ /https?:\/\/[\S]+/) == 0
      @document = document
    else
      @document = "file://#{document}"
    end

    java_cmd = 'java'
    java_args = '-server -Djava.awt.headless=true'
    tika_path = "#{File.join(File.dirname(__FILE__))}/../ext/tika-app-1.2.jar"

    @tika_cmd = "#{java_cmd} #{java_args} -jar '#{tika_path}'"
  end

  def to_xml
    run_tika('--xml')
  end

  def to_html
    run_tika('--html')
  end

  def to_json
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

    pid, stdin, stdout, stderr = Open4::popen4(final_cmd)

    stdout_result = stdout.read.strip
    stderr_result = stderr.read.strip

    unless strip_stderr(stderr_result).empty?
      raise(CommandFailedError.new(stderr_result),
            "execution failed with status #{stderr_result}: #{final_cmd}")
    end

    stdout_result
  ensure
    stdin.close
    stdout.close
    stderr.close
  end

  def strip_stderr(s)
    s.gsub(/^(info|warn) - .*$/i, '').strip
  end

end
