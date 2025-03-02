class SessionsController < ApplicationController
  def new
    @users = User.all
  end
  
  def create
    # TODO: authenticate user
    @user = User.find_by({ "email" => params["email"] })
    if @user != nil
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcom, #{@user["first_name"]}."
        redirect_to "/posts"
      else
        flash["notice"] = "Nope."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Nope."
      redirect_to "/login"
    end
  end

  def destroy
    flash["notice"] = "Goodbye"
    session["user_id"] = nil
    redirect_to "/login"
  end



end
