require 'spec_helper'

class TestController
  extend Documentary::Params
end

describe Documentary::Params do
  subject { TestController }

  describe "#params mock" do
    it "should have benn called" do
      expect(subject).to receive(:params)
      subject.params :show do
        optional(:type)
        required(:vintage)
      end
    end
  end

  describe "#params" do
    context "without nesting" do
      let(:year_desc) { 'Year of the vintage' }

      before do
        subject.params :show do
          optional(:type)
          required(:vintage, type: Integer, desc: 'Year of the vintage')
        end
      end

      it "should set params" do
        expect(subject.params).to be
      end

      it { expect(subject.params[:show][:vintage]).to be}
      it { expect(subject.params[:show][:vintage][:type]).to eq(Integer) }
      it { expect(subject.params[:show][:vintage][:desc]).to eq(year_desc) }
      it { expect(subject.params[:show][:vintage][:required]).to eq(true) }
      it { expect(subject.params[:show][:type][:required]).to eq(false) }
    end

    context "nested params" do
      let(:year_desc) { 'Year of the vintage' }

      before do
        subject.params :show do
          optional(:type)
          required(:vintage, type: Array) do
            required(:year, type: Integer, desc: 'Year of the vintage')
            optional(:month, type: Integer)
            optional(:day, type: Integer)
          end
        end
      end

      it { expect(subject.params).to be }
      it { expect(subject.params[:show][:vintage][:year][:type]).to eq(Integer) }
      it { expect(subject.params[:show][:vintage][:year][:desc]).to eq(year_desc) }
      it { expect(subject.params[:show][:vintage][:required]).to eq(true) }
      it { expect(subject.params[:show][:vintage][:type]).to eq(Array) }
      it { expect(subject.params[:show][:vintage][:year][:required]).to eq(true) }
      it { expect(subject.params[:show][:vintage][:day][:required]).to eq(false) }
    end
  end
end
