class PagesController < ApplicationController
  def index
    @pages = Page.order('updated_at desc').page(params[:page])
    
    respond_to do |format|
      format.html
    end
  end

  def show
    @page = Page.find(params[:id])
    if not @page.fetch_yahoo(params[:page])
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
      page = Page.create(:name => "Auctions related to #{query}", :query => query)
      redirect_to page_path(page)
    elsif @pages.count == 1
      redirect_to page_path(@pages[0]) 
    else
      @pages = @pages.page(params[:page])    
    end
  end


  def seller
    # search auction by seller id
    seller = Seller.find_or_create_by_name(params[:seller])
    seller.page = Page.create!(:name => 'Listing for ' + params[:seller]) if seller.page.nil?
    @page = seller.page
    if not @page.fetch_yahoo(:json)
      redirect_to root_path
    end
  end
end
