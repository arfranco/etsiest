require 'sinatra'
require 'pry'
require 'etsy'
require "etsiest/version"

Etsy.protocol = "https"
Etsy.api_key = ENV['ETSY_KEY']
request = Etsy.request_token
Etsy.verification_url


module Etsiest
  class App < Sinatra::Base

    get '/' do 
      if params[:q]
        response = Etsy::Request.get('/listings/active', :includes => ['Images', 'Shop'], :keywords => params[:q])
        @results = JSON.parse(response.body)['results']
      end
      erb :index
    end

    run! if app_file == $0
  end
end

binding.pry