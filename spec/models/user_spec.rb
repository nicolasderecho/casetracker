RSpec.describe User, type: :model do
  
  before(:each) do 
    @user = create(:user, first_name: "Ariel", last_name: "Zarate") 
  end

  describe "#to_s" do

    it "returns the full name" do
      expect(@user.to_s).to eq @user.full_name
    end

  end

end
