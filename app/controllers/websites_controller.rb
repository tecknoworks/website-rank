class WebsitesController < ApplicationController

  def index
    @websites = Website.order('id desc')
    @website = Website.new
  end

  api :POST, '/websites', ''
  description <<-EOS
  EOS
  def create
    @website = Website.create(website_params)
    if @website.valid?
      flash[:message] = "created"
    else
      flash[:message] = @website.errors
    end
    redirect_to :root
  end

  protected

  def website_params
    params.require(:website).permit(:url)
  end

end
