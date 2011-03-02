module PagesHelper
  def paginate_auctions
    per_page = 50
    window_size = 7
 
    first = @page.auctions['first']
    returned = @page.auctions['returned']
    total = @page.auctions['total']
 
    current_page = first/per_page + 1 if returned > 0
    num_pages = (total/per_page + 1).ceil
   
    if num_pages > 1
      window_center = (current_page - window_size/2 < 0) ? window_size/2 : current_page
      window_start = [window_center - window_size/2, 1].max
      window_end = [window_center + window_size/2, num_pages].min

      concat(content_tag(:div, :class => 'paginate_auctions') do
        concat prev_link(current_page)
        1.upto 2 do |page|
          concat page_link(page, current_page, window_start, window_end, num_pages)
        end
        [window_start-1, 3].max.upto [window_end+1, num_pages].min do |page|
          concat page_link(page, current_page, window_start, window_end, num_pages)
        end
        [num_pages-1, window_end+2].max.upto num_pages do |page|
          concat page_link(page, current_page, window_start, window_end, num_pages)          
        end
        concat next_link(current_page, num_pages)
      end
      )
    end
  end
  
  def page_link(page, current_page, window_start, window_end, num_pages)
    if current_page == page
      content_tag(:b, "#{page}  ")
    elsif page <= 2 or page >= num_pages-1
      link_to("#{page}  ", page_path(@page) + page_param(page))
    elsif page >= window_start and page <= window_end
      link_to("#{page}  ", page_path(@page) + page_param(page))      
    else
      "... "
    end
  end  
  
  def prev_link(current_page)
    link_to("&laquo; Prev ".html_safe, page_path(@page) + page_param(current_page-1)) if current_page > 1
  end
  
  def next_link(current_page, num_pages)
    link_to("Next &raquo; ".html_safe, page_path(@page) + page_param(current_page+1)) if current_page < num_pages
  end
  
  def page_param(page)
    "?page=#{page}"
  end
end
