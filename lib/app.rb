require 'sinatra/base'

class CloneWarsApp < Sinatra::Base

  set :method_override, true
  set :root, 'lib/app'

  get '/' do
    erb :index
  end

  get '/about' do
    erb :"about/about"
  end

  get '/about/:about' do
    erb :"about/about_views", :locals => {param: params[:about]}
  end

  get '/bike-shop' do
    erb :"bike_shop/bike_shop"
  end

  get '/bike-shop/:bike' do
    erb :"bike_shop/bike_shop_views", :locals => {param: params[:bike]}
  end

  get '/events/:events' do
    erb :"events/events_views", :locals => {param: params[:events]}
  end

  get '/links' do
    erb :"links/link"
  end

end
