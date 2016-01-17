module PplogBrowser
  module Client
    class Browser < AuthAutomator
      ZAPPING_URL = 'https://www.pplog.net/zapping'
      HOME_URL    = 'https://www.pplog.net/'

      def login
        @pplog = run_auth
      end

      def post(poem)
        return if poem.empty?
        form = new_post_page.forms.first
        form.field_with(name: 'post[content]').value = poem

        form.submit
      end

      def zapping
        user_name = '//span[@class="user-name"]/text()'
        title = '//div[@class="content"]/h1/text()'
        body = '//div[@class="content-body"]/text()'
        page = @agent.get(ZAPPING_URL)
        "#{page.xpath(user_name)}: #{page.xpath(title)}#{page.xpath(body)}"
      end

      private

      def new_post_page
        @pplog.link_with(href: '/my/posts/new').click
      end
    end
  end
end
