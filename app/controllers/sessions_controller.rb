class SessionsController < ApplicationController
  def new
    #new gives us a html form to fill our data from the user, its literally a form
  end
  
  def create
    #create now posts this data to the server and tells it to create this user or session in this case
    
    user = User.find_by(email: params[:session][:email].downcase)
    
    #the 1st "if user" is to check did we even load a user from the above line, is it even there?
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      render 'new' #this render new is to redisplay the page again, u know, to show we've logged in sucessfully
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
