# # frozen_string_literal: true
#
# require 'rails_helper'
#
# RSpec.describe Fav, type: :model do
#
# end
require 'rails_helper'
RSpec.describe Fav, type: :model do
  before do
    @alice    = FactoryBot.create(:alice)
    @artistA  = FactoryBot.create(:artistA)
    @fav      = Fav.new(user_id: @alice.id, artist_id: @artistA.id)
  end

  describe '属性の存在性バリデーション' do
    it 'should be valid' do
      expect(@fav).to be_valid
    end
    it "should require a artist_id" do
      @fav.artist_id = nil
      expect(@fav).to be_invalid
    end
  
    it "should require a following_id" do
      @fav.user_id = nil
      expect(@fav).to be_invalid
    end
  end
end