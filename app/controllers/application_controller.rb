# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_query

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Pundit

  def pundit_user
    current_account
  end

  def set_query
    @search = Account.ransack(params[:q])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user|
      user.permit(:user_name, :first_name, :last_name, :password, :email, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :last_name, :password, :email, :password_confirmation, :current_password, :description,
               :profile_picture, :type_of_account)
    end
  end

  private

  def user_not_authorized
    redirect_back(fallback_location: new_account_session_path,
                  notice: 'You are not authorized to perform this action.')
  end
end
