# app/controllers/api/api_controller.rb
class Api::ApiController < ApplicationController
  # API istekleri için CSRF korumasını devre dışı bırak
  protect_from_forgery with: :null_session
end