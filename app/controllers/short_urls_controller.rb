class ShortUrlsController < ApplicationController

  def index
    @short_url = ShortUrl.new
  end
  
  def create
    @short_url = ShortUrl.new(params[:short_url])
    
    unless @short_url.save
      redirect_to root_path
    end
  end
  
  def redirect_url
    @short_url = ShortUrl.find_from_encoded_key(params[:key])
    
    if @short_url
      redirect_to @short_url.url
    else
      redirect_to root_path(:url => :not_found)
    end
  end
end