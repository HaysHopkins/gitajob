require 'uri'
require 'net/http'
require 'benchmark'

module Gitajob
  class Health
    def initialize(website, repeat, frequency)
      @website = website
      @repeat = repeat
      @frequency = frequency
    end

    def probe
      @uri = URI.parse(@website)
      request_times = start_probe
      format_average_request_time(request_times)
    rescue Errno::ECONNREFUSED
      puts "Unable to connect. Check your website and try again."
    rescue URI::InvalidURIError
      puts "The provided website is invalid. Check your website and try again."
    end

    private

    def start_probe
      @repeat.times.to_a.map.with_index do |iteration|
        request_time = measure_request
        format_request_time(request_time)
        delay_next_request if iteration < @repeat-1
        request_time
      end
    end

    def measure_request
      Benchmark.measure do
        format_response(make_request)
      end.real
    end

    def make_request
      Net::HTTP.get_response(@uri)
    end

    def delay_next_request
      sleep @frequency
    end

    def format_response(res)
      print "#{@website} responded with #{res.code} - #{res.message}"
    end

    def format_request_time(time)
      puts " and the request took #{time} seconds."
    end

    def format_average_request_time(times)
      puts "After probing #{@website} #{@repeat} times over the course of #{(@repeat-1) * @frequency} seconds, the average request time was #{times.sum / times.size}."
    end
  end
end
