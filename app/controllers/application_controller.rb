class ApplicationController < ActionController::API
  before_action :cors_set_access_control_headers
  before_action :validation_error

  def cors_set_access_control_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Expose-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, ' \
    'Auth-Token, Email, X-User-Token, X-User-Email, x-xsrf-token'
  end


  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
        errors: [
            {
                status: '400',
                title: 'Bad Request',
                detail: resource.errors,
                code: '100'
            }
        ]
    }, status: :bad_request
  end
end
