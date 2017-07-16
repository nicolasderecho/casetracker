RSpec.describe Case, type: :model do

  describe "#to_s" do
    it "returns the title" do
      case_file = create(:case)
      expect(case_file.to_s).to eq(case_file.title)
    end
  end

end
