RSpec.describe Petrinet::Net do
  describe 'voting' do
    before do
      pn = Petrinet::Net.build do
        transition(:convert, take: :negative, give: :affirmative)
        transition(:dissent, take: :affirmative, give: :negative)
        transition(:yay, take: :vote, give: :affirmative)
        transition(:nay, take: :vote, give: :negative)
      end
      @pn = pn.mark(vote: 1)
    end

    it "allows a transition" do
      @pn.fire(:yay)
    end

    it "does not allow a transition" do
      @pn = @pn.fire(:yay)
      expect do
        @pn.fire(:yay)
      end.to raise_error('Cannot fire: yay')
    end

    it "enumerates fireable states" do
      expect(@pn.fireable).to eq(Set[:yay, :nay])
    end
  end

  describe ".from_pnml" do
    it "builds a net" do
      pn = Petrinet::Net.from_pnml(IO.read(File.dirname(__FILE__) + '/../examples/voting/voting.xml'))
      pn = pn.fire(:YAY)
      expect do
        pn.fire(:YAY)
      end.to raise_error('Cannot fire: YAY')
    end
  end

  describe ".to_svg" do
    it "produces an svg" do
      pn = Petrinet::Net.from_pnml(IO.read(File.dirname(__FILE__) + '/../examples/voting/voting.xml'))
      dot = pn.to_svg
      puts "----"
      puts dot
      puts "===="
    end
  end
end
