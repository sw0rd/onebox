class PagesController < ApplicationController
  def index
    @pages = Page.page(params[:page])
  end

  def show
    @page = Page.find(params[:id])
    @page.update_yahoo    
  end
  
  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to pages_url, :notice => "Successfully created page."
    else
      render :action => 'new'
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to pages_url, :notice => "Successfully destroyed page."
  end
end
