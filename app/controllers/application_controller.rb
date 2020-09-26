# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name
                                                         birthday
                                                         sex
                                                         introduction
                                                         image])
    # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
    # アカウント編集の時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name
                                                                birthday
                                                                introduction
                                                                image])
  end
end
