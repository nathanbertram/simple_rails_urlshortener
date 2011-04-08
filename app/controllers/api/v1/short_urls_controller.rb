class Api::V1::ShortUrlsController < ApplicationController
  before_filter :validate_api_key
  
  # POST /api/v1/ {:url_to_shorten => 'YARR.com', :api_key => '123456789'}
  def create
    @short_url = ShortUrl.new(:url => params[:url_to_shorten])
    
    if @short_url.save
      render :json => {:short_url => shortened_url(@short_url.encoded_key), :encoded_key => @short_url.encoded_key}
    else
      render :json => {:errors => @short_url.errors}
    end
  end
  
  private
  
  def validate_api_key
    unless ApiAccount.find_by_key(params[:api_key])
      render :json => {:errors => {:authentication => ['Invalid.']}}
    end
    return
  end

end