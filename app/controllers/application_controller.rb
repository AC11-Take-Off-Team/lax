<<<<<<< HEAD
class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search_group

  private

  def record_not_found
    render file: "#{Rails.root}/public/404.html",
           layout: false,
           status: 404
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end


class ApplicationController < ActionController::Base
  before_action :search_group

  def search_group
    @group_query = Group.ransack(params[:q])

  end
end
