# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '属性の存在性バリデーション' do
    let(:user) { User.new(params) }
    context '全ての属性が入力済みの場合' do
      let(:params) { { name: 'Ryoga', email: 'example@example.com', sex: '1', introduction: 'hello world', password: 'passpass', password_confirmation: 'passpass'} }
      it 'OKで通ること' do
        expect(user).to be_valid
      end
    end
    context 'nameの値が空の場合' do
      let(:params) { { name: '', email: 'example@example.com', sex: '1', introduction: 'hello world', password: 'passpass', password_confirmation: 'passpass'} }
      it 'エラーを返すこと' do
        expect(user).to be_invalid
      end
    end
    context 'emailの値が空の場合' do
      let(:params) { {name: 'Ryoga', email: '', sex: '1', introduction: 'hello world', password: 'passpass', password_confirmation: 'passpass' } }
        it 'エラーを返すこと' do
          expect(user).to be_invalid
      end
    end
  end

  before do
    @user = FactoryBot.build(:user)
  end
  describe 'nameとemailの長さの検証に対するテスト' do
    context 'nameが長すぎる時、failを期待する' do
      it 'failになっていない' do
        @user = FactoryBot.build(:user, name: 'a' * 51)
        expect(@user).to be_invalid
      end
    end
    context 'emailが長すぎる時、failを期待する' do
      it 'failになっていない' do
        @user = FactoryBot.build(:user, email: 'a' * 244 + '@example.com')
        expect(@user).to be_invalid
      end
    end
  end

  describe 'email検証の有効性に対するテスト' do
    it 'emailのvalidateが正しく機能しているか' do
      addresses = %w[user@example,com user_at_foo.org user.name@example.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        expect(FactoryBot.build(:user, email: invalid_address)).to be_invalid
      end
    end
    it 'emailの重複を拒否を正しく機能しているか' do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      expect(duplicate_user).to be_invalid
    end
  end

  describe 'passwordの有効性に対するテスト' do
    it 'passwordが６文字以上ならTrueを返す' do
      @user = FactoryBot.build(:user, password_is: 'a' * 6, password_confirmation_is: 'a' * 6)
      expect(@user).to be_valid
    end
    it 'passwordが5文字以下ならFalseを返す' do
      @user = FactoryBot.build(:user, password_is: 'a' * 5, password_confirmation_is: 'a' * 5)
      expect(@user).to be_invalid
    end
  end
end

RSpec.describe User, type: :model do
  xdescribe 'フォロー＆フォロー解除の有効性に対するテスト' do
    before do 
      @alice = FactoryBot.create(:alice)
      @bob   = FactoryBot.create(:bob)
    end
    it 'アリスはボブをフォローしていないこと' do
      expect(@alice.following?(@bob)).to be_invalid
    end
    it 'アリスはボブをフォローしていること' do
      @alice.follow!(@bob)
      expect(@alice.following?(@bob)).to be_valid
    end
    it 'ボブはアリスをフォロワーにいること' do
      expect(@bob.followers.include?(@alice)).to be_valid
    end
    it 'アリスはボブをフォロー解除していること' do
      @alice.unfollow!(@bob)
      expect(@alice.following?(@bob)).to be_invalid
    end
  end
end
