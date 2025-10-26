class ApplicationController < ActionController::Base
  # ログイン後は棚一覧へ
  def after_sign_in_path_for(resource)
    shelves_path
  end

  # 新規登録後も棚一覧へ
  def after_sign_up_path_for(resource)
    shelves_path
  end

  # ログアウト後はアプリ説明ページへ
  def after_sign_out_path_for(resource_or_scope)
    unauthenticated_root_path
  end
end
