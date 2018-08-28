# frozen_string_literal: true

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

  def initialize(document, config = nil)
    @config = config
    @document = if document =~ %r{https?:\/\/[\S]+}
                  document
                else
                  "file://#{document}"
                end

    java_cmd = 'java'
    java_args = '-server -Djava.awt.headless=true'
    tika_path = "#{File.join(File.dirname(__FILE__))}/../ext/tika-app-1.18.jar"

    @tika_cmd = "#{java_cmd} #{java_args} -jar '#{tika_path}' #{tika_config}"
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

    _pid, stdin, stdout, stderr = Open4.popen4(final_cmd)

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

  def strip_stderr(error_message)
    errors = error_message.split("\n")
    real_errors = errors.reject { |e| /(INFO|WARN)/i.match(e) }
    real_errors.empty? ? real_errors : real_errors.join("\n")
  end

  def tika_config
    "--config=#{tika_config_path}"
  end

  def tika_config_path
    @config || "#{File.join(File.dirname(__FILE__))}/../ext/tika-config.xml"
  end
end
