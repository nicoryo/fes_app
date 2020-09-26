# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'nameの値が空の場合、エラーを返すこと' do
      user = User.new(name: '', email: 'test_user@example.com', sex: '1', birthday: '2020_09_14', introduction: 'Hello world')
      expect(user.valid?).to eq(true)
    end

    it 'emailの値が空の場合、エラーを返すこと' do
      user = User.new(name: 'Ryoga', email: '', sex: '1', birthday: '2020_09_14', introduction: 'Hello world')
      expect(user.valid?).to eq(true)
    end

    it 'sexの値が空の場合、エラーを返すこと' do
      user = User.new(name: 'Ryoga', email: 'test_user@example', sex: '', birthday: '2020_09_14', introduction: 'Hello world')
      expect(user.valid?).to eq(true)
    end

    it 'birthdayの値が空の場合、エラーを返すこと' do
      user = User.new(name: 'Ryoga', email: 'test_user@example', sex: '1', birthday: '', introduction: 'Hello world')
      expect(user.valid?).to eq(true)
    end

    it 'introductionの値が空の場合、エラーを返すこと' do
      user = User.new(name: 'Ryoga', email: 'test_user@example', sex: '', birthday: '2020_09_14', introduction: '')
      expect(user.valid?).to eq(true)
    end
  end
end
