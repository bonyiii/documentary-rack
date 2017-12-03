require 'spec_helper'

describe Documentary::Router do
  let(:router) { described_class.new }
  let(:rack_env) do
    {
      'PATH_INFO' => path_info,
      'REQUEST_METHOD' => request_method
    }
  end

  before do
    router.config do
      get "/people", to: "person#index"
      get /.*/, to: "person#show"
    end
  end

  describe "#route_for" do
    subject { router.route_for(rack_env) }

    context "get" do
      let(:request_method) { 'GET' }

      context "when path is defined" do
        let(:path_info) { '/people' }

        it { expect(subject.path).to eq("/people") }
        it { expect(subject.instance_method).to eq("index") }
      end

      context "when path is not defined match all rule is defined" do
        let(:path_info) { '/not_defined' }

        it { expect(subject.path).to eq(/.*/) }
        it { expect(subject.instance_method).to eq('show') }
      end
    end

    context "option" do
      let(:request_method) { 'OPTION' }

      context "when path is defined" do
        let(:path_info) { '/people' }

        it { expect(subject.path).to eq("/people") }
        it { expect(subject.instance_method).to eq("index") }
      end

      context "when path is not defined" do
        let(:path_info) { '/not_defined' }

        it { expect(subject).not_to be }
        it { expect(subject).not_to be }
      end
    end
  end
end
