require 'sinatra/base'

require './lib/page_store'
require './lib/text-converter'
require 'pry'

class CloneWarsApp < Sinatra::Base

  set :method_override, true
  set :root, 'lib/app'

  get '/' do
    page = PageStore.find('/')
    text = TextConverter.to_html(page[:text])
    erb :page_view, :locals => {text: text}
  end

  get '/about' do
    page = PageStore.find("/about")
    text = TextConverter.to_html(page[:text])
    erb :page_view, :locals => {text: text}
  end

  get '/about/:about' do |slug|
    page = PageStore.find("/about/#{slug}")
    text = TextConverter.to_html(page[:text])
    erb :page_view, :locals => {param: slug, text: text}
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

  get '/programs' do
    page = PageStore.find("/programs")
    text = TextConverter.to_html(page[:text])
    erb :"programs/programs"
  end

  get '/programs/:program' do
    erb :"programs/programs_views", :locals => {param: params[:program]}
  end

  get '/support' do
    erb :"support/support"
  end

  get '/support/:support' do
    erb :"support/support_views", :locals => {param: params[:support]}
  end

end
