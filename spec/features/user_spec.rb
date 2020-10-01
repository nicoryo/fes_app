require 'rails_helper'

RSpec.describe 'ログインとログアウト', type: :feature do
  before do
    # ユーザを作成する
    User.create!(name: 'Bob#1', email: 'foo@example.com', password: 'passpass', sex:'1', birthday: '1991.8.31', introduction: 'Hello')
  end
  it 'ログインする' do
    visit root_path
    click_on 'Log in'
    fill_in 'Email', with: 'foo@example.com'
    fill_in 'Password', with: 'passpass'
    click_on 'Log in'
    # ログアウトに成功したことを検証する
    expect(page).to have_content 'Signed in successfully.'
  end

  it 'ログアウトする' do
    visit root_path
    click_on 'Log in'
    fill_in 'Email', with: 'foo@example.com'
    fill_in 'Password', with: 'passpass'
    click_on 'Log in'
    click_on '<プロフィール変更>'
    click_on 'ログアウト'
    expect(page).to have_content 'Signed out successfully.'
  end

  it 'ログインに失敗する　パス間違い' do
    visit root_path
    click_on 'Log in'
    fill_in 'Email', with: 'foo@example.com'
    fill_in 'Password', with: 'idontknowpassword'
    click_on 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'ログインに失敗する メールアドレス間違い' do
    visit root_path
    click_on 'Log in'
    fill_in 'Email', with: 'hogehoge@example.com'
    fill_in 'Password', with: 'passpass'
    click_on 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end
end

RSpec.feature 'User', type: :feature do
  it 'ユーザー登録ができるか' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_name', with: 'ミニマムくん'
    fill_in 'user_email', with: 'minimum@example.co.jp'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    choose  'user_sex_1'
    # select '2011/01/01', from: 'user_birthday'
    fill_in 'user_introduction', with: 'Hello World'
    click_on 'SIGN UP'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end

RSpec.describe 'ユーザー登録に失敗', type: :feature do
  before do
      # ユーザを作成する
      User.create!(name: 'Bob#2', email: 'bob@example.com', password: 'passpass', sex:'1', birthday: '1991.8.31', introduction: 'Hello')
    end
  it 'メールアドレス被りver' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_name', with: 'ミニマムくん'
    fill_in 'user_email', with: 'bob@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    choose  'user_sex_1'
    # select '2011/01/01', from: 'user_birthday'
    fill_in 'user_introduction', with: 'Hello World'
    click_on 'SIGN UP'
    expect(page).to have_content('Email has already been taken')
  end
  it 'メールアドレス is nill ver' do
    visit root_path
    click_on 'Sign up'
    fill_in 'user_name', with: 'ミニマムくん'
    fill_in 'user_email', with: ''
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    choose  'user_sex_1'
    # select '2011/01/01', from: 'user_birthday'
    fill_in 'user_introduction', with: 'Hello World'
    click_on 'SIGN UP'
    expect(page).to have_content("Email can't be blank")
  end
end
