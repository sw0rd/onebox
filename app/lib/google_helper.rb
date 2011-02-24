module GoogleHelper
  def google_translate(text)
    url = "https://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=#{CGI::escape(text)}&langpair=ja%7Cen&key=#{GOOGLE_API}"
    doc = JSON.load(open(url))
    return doc['responseData']['translatedText']
  end
end
