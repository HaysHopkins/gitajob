require 'thor'

module Gitajob
  class CLI < Thor

    desc "probe", "Probe a website a given number of times over a given interval"
    method_option :website, :aliases => "-w", :desc => "Specify a website", :type => :string, :default => "https://about.gitlab.com"
    method_option :repeat, :aliases => "-r", :desc => "Specify number of times to probe", :type => :numeric, :default => 2
    method_option :frequency, :aliases => "-f", :desc => "Specify probing frequency in seconds", :type => :numeric, :default => 5, :enum => [5, 10, 15, 30, 60]

    def probe
      health.probe
    end

    private

    def health
      Gitajob::Health.new(options[:website], options[:repeat], options[:frequency])
    end
  end
end
