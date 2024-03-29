# app/controllers/users/passwords_controller.rb
# because strong_parameters breaks devise
# https://gist.github.com/kazpsp/3350730

class Users::PasswordsController < Devise::PasswordsController
  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  private :resource_params
end