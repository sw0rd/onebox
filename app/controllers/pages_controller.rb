class PagesController < ApplicationController
  def index
    @pages = Page.order('updated_at desc').page(params[:page])
  end

  def show
    @page = Page.find(params[:id])
    if not @page.fetch_yahoo(:json)
      redirect_to @page.url
    end
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
  
  
  def search
    @pages = Page
    params[:query].split('+').each do |text|
      @pages = @pages.where(:name =~ "%#{text}%")
    end
    
    if @pages.nil? or @pages.count == 0
      query = params[:query].gsub(/\+/, ' ')
      Page.create(:name => "Auctions related to #{query}", :query => query)
      @pages = Page.where(:query => query)
    end
    redirect_to page_path(@pages[0]) if @pages.count == 1  # Jump to page if only one result is shown
    @pages = @pages.page(params[:page])    
  end
end
