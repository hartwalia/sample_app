class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionsHelper #sessions_helper is basically a class we kinda wrote
                         #there this line ncecassary to import the class 
                         #we are importing it here because application controller is global like
                         #it grants everything access to the session_helper "class" we wrote
  
  def hello
    render text: "hello, world!"
  end
  
end
