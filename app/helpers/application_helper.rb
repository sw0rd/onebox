module ApplicationHelper
  def yen(number)
    number_to_currency(number, :locate => :ja, :unit => 'JPY ', :precision => 0)
  end
  
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
