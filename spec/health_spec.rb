RSpec.describe Gitajob::Health do
  let!(:website) { "https://about.gitlab.com" }
  let!(:repeat) { 1 }
  let!(:frequency) { 5 }

  it "outputs website response to stdout" do
    VCR.use_cassette("gitlab_response") do
      expect {
        Gitajob::Health.new(website, repeat, frequency).probe
      }.to output(/https:\/\/about.gitlab.com responded with/).to_stdout
    end
  end

  it "outputs average request time to stdout" do
    VCR.use_cassette("gitlab_response") do
      expect {
        Gitajob::Health.new(website, repeat, frequency).probe
      }.to output(/After probing https:\/\/about.gitlab.com 1 times over the course of 0 seconds, the average request time was/).to_stdout
    end
  end
end
