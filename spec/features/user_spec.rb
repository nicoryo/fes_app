require 'rails_helper'

RSpec.describe 'エラーが発生しない事を確認する', type: :feature do
  before do
    # ユーザを作成する
    User.create!(name: 'Bob#1', email: 'foo@example.com', password: 'passpass', sex: '1', birthday: '1991.8.31', introduction: 'Hello')
  end

  it 'ログインページにアクセスする' do
    visit new_user_session_path

    # ログアウトに成功したことを検証する
    expect(page).to have_content 'Forgot your password?'
  end

  it 'ログインする' do
    visit new_user_session_path
    fill_in 'user[email]', with: 'foo@example.com'
    fill_in 'user[password]', with: 'passpass'
    click_on 'Sent'
    # ログインに成功したことを検証する
    expect(page).to have_content 'Signed in successfully.'
  end

  it 'ログアウトする' do
    visit new_user_session_path
    fill_in 'user[email]', with: 'foo@example.com'
    fill_in 'user[password]', with: 'passpass'
    click_on 'Sent'
    page.all('.item')[4].click
    # ログアウトに成功したことを検証する
    expect(page).to have_content 'Signed out successfully.'
  end

  it 'ユーザーを登録する' do
    visit new_user_registration_path
    fill_in 'user_name', with: 'ミニマムくん'
    fill_in 'user_email', with: 'minimum@example.co.jp'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    choose  'user_sex_1'
    # select '2011/01/01', from: 'user_birthday'
    fill_in 'user_introduction', with: 'Hello World'
    click_on 'Sent'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end

RSpec.describe 'エラーが返る事を確認する', type: :feature do
  before do
    # ユーザを作成する
    User.create!(name: 'Bob#2', email: 'bob@example.com', password: 'passpass', sex: '1', birthday: '1991.8.31', introduction: 'Hello')
  end

  it 'パス間違いでログインに失敗' do
    visit new_user_session_path
    fill_in 'user_email', with: 'foo@example.com'
    fill_in 'user_password', with: 'idontknowpassword'
    click_on 'Sent'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'メールアドレス間違いでログインに失敗' do
    visit new_user_session_path
    fill_in 'user_email', with: 'hogehoge@example.com'
    fill_in 'user_password', with: 'passpass'
    click_on 'Sent'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it '登録済みのメールアドレスを入力して登録失敗' do
    visit new_user_registration_path
    fill_in 'user_name', with: 'ミニマムくん'
    fill_in 'user_email', with: 'bob@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    choose  'user_sex_1'
    # select '2011/01/01', from: 'user_birthday'
    fill_in 'user_introduction', with: 'Hello World'
    click_on 'Sent'
    expect(page).to have_content('Email has already been taken')
  end

  it 'メールアドレス未記入で登録失敗' do
    visit new_user_registration_path
    fill_in 'user_name', with: 'ミニマムくん'
    fill_in 'user_email', with: ''
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    choose  'user_sex_1'
    # select '2011/01/01', from: 'user_birthday'
    fill_in 'user_introduction', with: 'Hello World'
    click_on 'Sent'
    expect(page).to have_content("Email can't be blank")
  end
end
