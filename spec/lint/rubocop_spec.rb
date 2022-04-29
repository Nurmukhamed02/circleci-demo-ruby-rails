require "spec_helper"

RSpec.describe "Check that the files we have changed have correct syntax" do
  before do
    current_sha = `git rev-parse --verify HEAD`.strip!
    files = `git diff master #{current_sha} --name-only | grep .rb`
    files.tr!("\n", " ")
    @report = `rubocop #{files}`
    puts "Report: #{@report}"
  end

  it { expect(@report.match("Offenses")).to be_nil, "Rubocop offenses found.\n#{@report}" }
end
