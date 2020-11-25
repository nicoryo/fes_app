require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do 
    @alice   = FactoryBot.create(:alice)
    @artistA = FactoryBot.create(:artistA)
    @comment = Comment.new(content: "YaY", user_id: @alice.id, artist_id: @artistA.id)
  end
  describe '属性の存在性バリデーション' do
    it 'should be valid' do
      expect(@comment).to be_valid
    end
    it "user id should be present" do
      @comment.user_id = nil
      expect(@comment).to be_invalid
    end
    it "content should be present" do
      @comment.content = "   "
      expect(@comment).to be_invalid
    end
    it "content should be at most 255 characters" do
      @comment.content = "a" * 256
      expect(@comment).to be_invalid
    end
    xit "order should be most recent first" do
      expect(comment(:most_recent)).to  Comment.first
    end
  end
end