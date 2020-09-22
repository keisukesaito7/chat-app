require 'rails_helper'

RSpec.describe "User_login", type: :system do
  it "ログインしていない状態でトップページにアクセスした時、サインインページへリダイレクト" do
    # トップページへ遷移
    visit root_path

    # ログインしていない場合、サインインページに遷移していることを確認
    expect(current_path).to eq new_user_session_path
  end

  it "ログインに成功し、トップページに遷移する" do
    # 予め、ユーザーをDBに保存
    @user = FactoryBot.create(:user)

    # サインインページへ遷移する
    visit new_user_session_path

    # email, passを入力する
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password

    # binding.pry
    # ログインボタンをクリック
    # find('input[name="commit"]').click
    click_on "Log in"

    # トップページに遷移していることを確認する
    expect(current_path).to eq root_path
  end

  it "ログインに失敗し、再びサインインページへ戻ってくる" do
    # 予め、ユーザーをDBに保存
    @user = FactoryBot.create(:user)

    # トップページへ遷移
    visit root_path

    # 未ログイン時はサインインページへ遷移を確認
    expect(current_path).to eq new_user_session_path

    # 誤ったユーザー情報を入力
    @wrong_user = FactoryBot.build(:user)
    fill_in "Email", with: @wrong_user.email
    fill_in "Password", with: @wrong_user.password

    # ログインボタンクリック
    # find('input[name="commit"]').click
    click_on "Log in"

    # サインインページに戻ってくる
    expect(current_path).to eq new_user_session_path
  end
end
