require 'sinatra/base'
require 'pry'
require 'etsy'
require "etsiest/version"


Etsy.api_key = ENV['ETSY_KEY']



module Etsiest
  class App < Sinatra::Base

    get '/etsy_search' do 
      @search = params['q']
      #@results = []
      if params['q']
        response = Etsy::Request.get('/listings/active', :includes => ['Images', 'Shop'], :keywords => "#{@search}")
        @results = JSON.parse(response.body)['results']
      end
      erb :index
    end

    run! if app_file == $0
  end
end

binding.pry