class HomeController < ApplicationController
  before_action :set_active_storage_url_options

  def index
    @products = Product.all
  end

  private

  def set_active_storage_url_options
    ActiveStorage::Current.url_options = {
      protocol: request.protocol,
      host: request.host,
      port: request.port
    }
  end
end
