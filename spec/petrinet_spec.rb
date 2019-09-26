RSpec.describe Petrinet::Net do
  describe 'voting' do
    before do
      @pn = Petrinet::Net.build do
        transition(:convert, take: :negative, give: :affirmative)
        transition(:dissent, take: :affirmative, give: :negative)
        transition(:yay, take: :vote, give: :affirmative)
        transition(:nay, take: :vote, give: :negative)
        token(:vote, 1)
      end
    end

    it "allows a transition" do
      @pn.fire(:yay)
    end

    it "does not allow a transition" do
      @pn.fire(:yay)
      expect do
        @pn.fire(:yay)
      end.to raise_error('Cannot fire: yay')
    end
  end
end
