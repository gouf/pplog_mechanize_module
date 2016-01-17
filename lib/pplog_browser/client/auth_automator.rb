require 'mechanize'
require 'memoizable'

module PplogBrowser
  module Client
    class AuthAutomator
      TWITTER_AUTH_URL = 'https://www.pplog.net/users/auth/twitter'
      CONFIRM_LINK     = { text: 'click here to continue' }
      USER_NAME_INPUT  = { name: 'session[username_or_email]' }
      PASSWORD_INPUT   = { name: 'session[password]' }

      def initialize
        @user_name = ENV['PPLOG_USER_NAME']
        @password  = ENV['PPLOG_PASSWORD']
        @agent = Mechanize.new
      end

      def run_auth
        pplog_home_page
      end

      private

      attr_reader :password

      def pplog_home_page
        # Run authorize
        page = open_twitter_page
        page = login_to_twitter(page)
        passing_confirmation(page)
      end

      def open_twitter_page # 1 -> login_to_twitter
        # request login page
        @agent.get(TWITTER_AUTH_URL)
      end

      def login_to_twitter(page) # 2 -> pass_confirmation
        # filling up form(username / password)
        form = page.forms.first
        form.field_with(USER_NAME_INPUT).value = @user_name
        form.field_with(PASSWORD_INPUT).value  = @password

        # submit form
        submit_button = form.buttons.first
        form.submit(submit_button)
      end

      def passing_confirmation(page) # 3 -> return pplog_page
        # allow authorize
        pplog_page = page.link_with(CONFIRM_LINK).click
        fail 'Login Failed' if pplog_page.nil?
        pplog_page
      end
    end
  end
end
