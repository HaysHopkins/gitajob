require 'uri'
require 'net/http'
require 'benchmark'

module Gitajob
  class Health
    def initialize(website, repeat, frequency)
      @uri = URI.parse(website)
      @website = website
      @repeat = repeat
      @frequency = frequency
    end

    def probe
      times = start_probe
      format_average_request_time(times)
    end

    private

    def start_probe
      @repeat.times.to_a.map.with_index do |iteration|

        request_time = Benchmark.measure do
          format_response(make_request)
        end.real

        format_request_time(request_time)
        delay_next_request if iteration < @repeat-1

        request_time
      end
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
      puts "After probing #{@website} #{@repeat} times over the course of #{(@repeat-1) * @frequency} seconds, the average request time #{times.sum / times.size}."
    end
  end
end