require_relative 'module/mechanize/mec'

class Honekuru
  include PoemPoster

  def initialize
    pplog_zapped_page
  end

  def reload!
    @page = @page.link_with(:href => '/zapping').click
    reload! if ignore_cases_matched?
  end

  def ignore_cases_matched?
    return false if @page.nil?
    user = (user_name == '@sushi_pedia')
    title = ! title().match(/^.*\.md$/).nil?
    user || title
  end

  def content
    content = '/html/body/div[2]/section/div[2]'
    @page.search(content)
  end

  def title
    content().search('h1').text
  end

  def body
    content().search('div[@class=content-body]').text
  end

  def created_at
    content().search('div[@class=created-at]').text
  end

  def user_name
    @page.search('div[@class=user-info]/span[@class=user-name]').text
  end

  def video
    content().search('div[@class=video-container]/iframe').attr('src')
  end

  :private
  def pplog_zapped_page
    return reload! if ignore_cases_matched?
    return @page unless @page.nil?
    page = super
    @page = page
  end

  alias_method :rezap!, :reload!
end
