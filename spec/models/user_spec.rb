require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#create" do
    before do
      @user = FactoryBot.build(:user)
    end
    
    it "nameとemail, passwordとpassword_confirmationが存在すれば保存できること" do
      expect(@user).to be_valid  
    end
    
    it "nameが空では登録できないこと" do
      # binding.pry
      @user.name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "emailが空では登録できないこと" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "passwordが空では登録できないこと" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "passwordが6文字以上であれば登録できること" do
      # binding.pry
      password = "aaaaaa"
      @user.password = password
      @user.password_confirmation = password
      expect(@user).to be_valid
    end

    it "passwordが5文字以下であれば登録できないこと" do
      # binding.pry
      password = "aaaaa"
      @user.password = password
      @user.password_confirmation = password
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "重複したemailが存在する場合登録できないこと" do
      # binding.pry
      user2 = FactoryBot.create(:user)
      @user.email = user2.email
      @user.valid?
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end
  end
end
