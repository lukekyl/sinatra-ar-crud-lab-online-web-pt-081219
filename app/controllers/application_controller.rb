
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/articles/new' do
    erb :new
  end
  post '/articles' do
    Article.create(title: params[:title], content: params[:content])
    redirect "/articles/#{Article.last.id}"
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do 
    @article = Article.find(params[:id])
    erb :edit
  end
  patch '/articles/:id' do 
    @article = Article.find(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    # params.each do |param|
    #   if @article.param != param.value
    #     @article.param = param.value
    #   end
    # end
    @article.save
    redirect "/articles/#{Article.last.id}"
  end
  delete '/articles/:id' do
    @article = Article.find(params[:id])
    @article.destroy
  end
end
