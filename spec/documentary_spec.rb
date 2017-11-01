require "spec_helper"

describe Docuementary do
  it "has a version number" do
    expect(Wheel2::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end

  it "should be ok" do
    expect(RequestController.new).to be
  end
end
