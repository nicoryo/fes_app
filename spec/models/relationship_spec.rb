# # frozen_string_literal: true
#
# require 'rails_helper'
#
# RSpec.describe Relationship, type: :model do
#
# end

require 'rails_helper'
RSpec.describe Relationship, type: :model do
  before do
    @alice = FactoryBot.create(:alice)
    @bob   = FactoryBot.create(:bob)
    @relationship = Relationship.new(follower_id: @alice.id,
    following_id: @bob.id)
  end

  describe '属性の存在性バリデーション' do
    context 'パラメータ確認' do
      it 'OKで通ること' do
        expect(@alice.name).to eq "Alice"
      end
      it 'OKで通ること' do
        expect(@alice.id).to be >= 0
      end
    end
  end

  describe '属性の存在性バリデーション' do
    context 'should be valid' do
      it 'OKで通ること' do
        expect(@relationship).to be_valid
      end
    end

    context "should require a follower_id" do
      it 'エラーを発生させること' do
        @relationship.follower_id = nil
        expect(@relationship).to be_invalid
      end
    end
  
    context "should require a following_id" do
      it 'エラーを発生させること' do
        @relationship.following_id = nil
        expect(@relationship).to be_invalid
      end
    end
  end
end