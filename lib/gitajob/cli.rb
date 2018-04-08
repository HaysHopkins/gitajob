require 'thor'

module Gitajob
  class CLI < Thor

    desc "probe", "Probe a website a given number of times over a given interval"
    method_option :website, aliases: "-w", desc: "Specify a website", type: :string, default: "https://about.gitlab.com"
    method_option :repeat, aliases: "-r", desc: "Specify number of times to probe", type: :numeric, default: 7, enum: (1..100).to_a
    method_option :frequency, aliases: "-f", desc: "Specify probing frequency in seconds", type: :numeric, default: 10, enum: (5..60).to_a

    def probe
      health.probe
    end

    private

    def health
      Gitajob::Health.new(options[:website], options[:repeat], options[:frequency])
    end
  end
end
