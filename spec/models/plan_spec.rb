RSpec.describe Plan, type: :model do
  describe '#>' do
    subject { plan > comparison_plan }

    let(:plan) { Plan.new(level: level) }
    let(:comparison_plan) { Plan.new(level: comparison_level) }

    context "the subject is 'free'" do
      let(:level) { 'free' }
      
      context "the comparison is 'free'" do
        let(:comparison_level) { 'free' }

        it { is_expected.to be(false) }
      end

      context "the comparison is 'basic'" do
        let(:comparison_level) { 'basic' }

        it { is_expected.to be(false) }
      end

      context "the comparison is 'pro'" do
        let(:comparison_level) { 'pro' }

        it { is_expected.to be(false) }
      end
    end

    context "the subject is 'basic'" do
      let(:level) { 'basic' }
      
      context "the comparison is 'free'" do
        let(:comparison_level) { 'free' }

        it { is_expected.to be(true) }
      end

      context "the comparison is 'basic'" do
        let(:comparison_level) { 'basic' }

        it { is_expected.to be(false) }
      end

      context "the comparison is 'pro'" do
        let(:comparison_level) { 'pro' }

        it { is_expected.to be(false) }
      end
    end

    context "the subject is 'pro'" do
      let(:level) { 'pro' }
      
      context "the comparison is 'free'" do
        let(:comparison_level) { 'free' }

        it { is_expected.to be(true) }
      end

      context "the comparison is 'basic'" do
        let(:comparison_level) { 'basic' }

        it { is_expected.to be(true) }
      end

      context "the comparison is 'pro'" do
        let(:comparison_level) { 'pro' }

        it { is_expected.to be(false) }
      end
    end
  end
end