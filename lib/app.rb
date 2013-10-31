require 'sinatra/base'

require './lib/page_store'
require './lib/text-converter'
require 'pry'

class CloneWarsApp < Sinatra::Base

  set :method_override, true
  set :root, 'lib/app'
  set :counter => 0

  get '/' do
    text = converted_page('/')
    erb :index, :locals => {text: text}
  end

  get '/admin' do
    protected!
    page = PageStore.find('/')
    erb :edit, :locals => {text: page[:text], path: nil}
  end

  get '/admin/*' do
    page = PageStore.find("/#{params[:splat].first}")
    erb :edit, :locals => {text: page[:text], path: page[:path]}
  end

  get '/*' do
    text = converted_page("/#{params[:splat].first}")
    erb :index, :locals => {text: text}
  end

  put '/admin' do
    protected!
    page = params[:page]
    PageStore.update("/", :text => page[:text].strip)
    redirect "/admin"
  end

  put '/admin/*' do
    protected!
    page = params[:page]
    PageStore.update("/#{params[:splat].first}", :text => page[:text].strip)
    redirect "/#{params[:splat].first}"
  end

  def converted_page(path)
    page = PageStore.find(path)
    TextConverter.to_html(page[:text])
  end

  # _________________________

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

  get '/links/:link' do
    erb :"links/links_views", :locals => {param: params[:link]}
  end

  get '/support' do
    erb :"support/support"
  end

  get '/support/:support' do
    erb :"support/support_views", :locals => {param: params[:support]}
  end

  helpers do

    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = "Basic realm='Restricted Area'"
      halt 401, 'Not authorized\n'
    end

    def authorized?
      @auth ||= Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == ['admin', 'admin']
    end

  end


end
