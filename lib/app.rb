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
    erb :"about/about_main", :locals => {param: params[:about]}
  end

  # get '/about/mission-vision-values' do
  #   erb :"about/mission_vision_values"
  # end

  # get '/about/contact_and_hours' do
  #   erb :"about/contact_and_hours"
  # end

end
