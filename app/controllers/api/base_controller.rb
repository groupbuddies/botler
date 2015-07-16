class API::BaseController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }
end
