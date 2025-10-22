class HelloController < ApplicationController
  def index
    render json: { message: "Merhaba, Bu proje bir blog apisidir. Proje Buğra DURMUŞ tarafından hazırlanmıştır." }
  end
end