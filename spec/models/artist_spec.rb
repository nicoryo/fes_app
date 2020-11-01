# # frozen_string_literal: true

require 'rails_helper'

RSpec.describe Artist, type: :model do
  before do
    @artist = FactoryBot.build(:artist)
  end
  describe '重複拒否を正しく機能する検証に対するテスト' do
    it 'idの重複を拒否を正しく機能しているか' do
      duplicate_artist = @artist.dup
      duplicate_artist.id = @artist.id
      @artist.save
      expect(duplicate_artist).to be_invalid
    end
    it 'nameの重複を拒否を正しく機能しているか' do
      duplicate_artist = @artist.dup
      duplicate_artist.name = @artist.name
      @artist.save
      expect(duplicate_artist).to be_invalid
    end
  end

  describe '属性の存在性バリデーション' do
    context 'nameがnillの場合' do
      it 'failを返す' do
        @artist = FactoryBot.build(:artist, name: '')
        expect(@artist).to be_invalid
      end
    end
  end
end
