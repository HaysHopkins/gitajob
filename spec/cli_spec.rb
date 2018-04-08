RSpec.describe Gitajob::CLI do
  let!(:args) { ["-w", "https://about.gitlab.com", "-r", 1, "-f", 5] }

  it "calls probe method of the health class" do
    expect_any_instance_of(Gitajob::Health).to receive(:probe)
    script = Gitajob::CLI.new(args)
    script.invoke_all
  end
end
