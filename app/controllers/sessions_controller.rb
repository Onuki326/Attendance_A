class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'ログインしました'
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      if admin_user?
        redirect_back_or admin_users_path
      else  
        redirect_back_or user
      end  
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'メールアドレスとパスワードの組み合わせが違います'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
end
