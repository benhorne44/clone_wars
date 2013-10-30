require 'sinatra/base'

require './lib/page_store'
require './lib/text-converter'
require 'pry'

class CloneWarsApp < Sinatra::Base

  set :method_override, true
  set :root, 'lib/app'
  set :counter => 0

  get '/' do
    page = PageStore.find('/')
    text = TextConverter.to_html(page[:text])
    erb :index, :locals => {text: text}
  end

  get '/about' do
    page = PageStore.find("/about")
    text = TextConverter.to_html(page[:text])
    erb :"about/about", :locals => {text: text}
  end

  get '/about/:slug' do |slug|
    page = PageStore.find("/about/#{slug}")
    text = TextConverter.to_html(page[:text])
    erb :"about/about_views", :locals => {param: slug, text: text}
  end

  get '/programs' do
    page = PageStore.find("/programs")
    text = TextConverter.to_html(page[:text])
    erb :page_view, :locals => {:text => text}
  end

  get '/programs/:slug' do |slug|
    page = PageStore.find("/programs/#{slug}")
    text = TextConverter.to_html(page[:text])
    erb :"programs/programs_views", :locals => {param: slug, text: text}
  end

  get '/admin' do
    protected!
    page = PageStore.find('/')
    text = (page[:text])
    erb :"admin_views", :locals => {param: "/", text: text}
  end

  put '/admin' do
    protected!
    page = params[:page]
    PageStore.update("/", :text => page[:text].strip)
    redirect "/admin"
  end

  get '/admin/about' do
    protected!
    page = PageStore.find('/about')
    text = (page[:text])
    erb :"admin_about", :locals => {param: "about", text: text}
  end

  put '/admin/about' do
    protected!
    page = params[:page]
    PageStore.update("/about", :text => page[:text].strip)
    redirect "/admin/about"
  end

  get '/admin/about/:slug' do |slug|
    protected!
    page = PageStore.find("/about/#{slug}")
    text = (page[:text])
    erb :"admin_about", :locals => {param: "#{slug}", text: text}
  end

  put '/admin/about/:slug' do |slug|
    protected!
    page = params[:page]
    PageStore.update("/about/#{slug}", :text => page[:text].strip)
    redirect "/admin/about/#{slug}"
  end

  get '/admin/programs' do
    protected!
    page = PageStore.find('/programs')
    text = (page[:text])
    erb :"admin_programs", :locals => {param: "programs", text: text}
  end

  put '/admin/programs' do
    protected!
    page = params[:page]
    PageStore.update("/programs", :text => page[:text].strip)
    redirect "/admin/programs"
  end

  get '/admin/programs/:slug' do |slug|
    protected!
    page = PageStore.find("/programs/#{slug}")
    text = (page[:text])
    erb :"admin_programs", :locals => {param: "/#{slug}", text: text}
  end

  put '/admin/programs/:slug' do |slug|
    protected!
    page = params[:page]
    PageStore.update("/programs/#{slug}", :text => page[:text].strip)
    redirect "/admin/programs/#{slug}"
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
