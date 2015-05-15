class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_authorization_check

  def headquarters
    user = headquarters_user(auth_hash.info.email)

    if user.persisted?
      handle_success(user)
    else
      handle_failure
    end
  end
  
  private

  def handle_success(user)
    sign_in_and_redirect user, event: :authentication
    set_flash_message(:notice, :success, kind: :headquarters) if is_navigational_format?
  end

  def handle_failure
    session['devise.headquarters_data'] = request.env['omniauth.auth']
    redirect_to root_url
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def headquarters_user(email)
    data = Headquarters::Client::Members.new(
      client_id: ENV['HQ_APP_ID'],
      client_secret: ENV['HQ_APP_SECRET']
    ).search(email).first
    return if data.nil?

    find_or_create_from_headquarters(data)
  end

  def find_or_create_from_headquarters(data)
    User.where(email: data['email']).first_or_create do |user|
      user.name = data['name']
      user.email = data['email']
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
