class ApplicationController < ActionController::Base
# deviseの機能使用される前にconfigure_permitted_parametersが実行されます
before_action :configure_permitted_parameters, if: :devise_controller?

# 新規登録後のpath
def after_sign_up_path_for(resource)
    public_item_top_path
end

# ログイン後のpath
def after_sign_in_path_for(resource)
  case resource
  when Admin
    admin_order_top_path
  when Customer
    public_item_top_path
  end
end

# ログアウト後のリダイレクト先
def after_sign_out_path_for(resource)
  if resource == :admin
    new_admin_session_path
  else
    public_item_top_path
  end
end

protected
  # devise_parameter_sanitizer.permitでlast_nameを操作する許可するアクションメソッドが指定されています
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name_kana])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name_kana])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:postal_code])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:address])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:telephone_number])
  end
end
