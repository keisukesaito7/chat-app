require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "#create" do
    before do
      @message = FactoryBot.build(:message)
    end

    it "contentとimageが存在していれば登録可能" do
      expect(@message).to be_valid
    end

    it "contentが存在していれば保存できる" do
      @message.content = nil
      expect(@message).to be_valid
    end

    it "imageが存在していれば保存できる" do
      @message.image = nil
      expect(@message).to be_valid
    end

    it "contentとimageが空では保存できない" do
      @message.content = nil
      @message.image = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Content can't be blank")
    end

    it "roomが紐づいていないと保存できない" do
      # binding.pry
      @message.room = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("Room must exist")
    end

    it "userが紐づいていないと保存できない" do
      @message.user = nil
      @message.valid?
      expect(@message.errors.full_messages).to include("User must exist")
    end

  end
end
