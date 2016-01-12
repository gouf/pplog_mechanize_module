require_relative 'lib/poem_poster/client'
require 'dotenv'

Dotenv.load

pplog = PplogBrowser::Client::Browser.new

puts pplog.zapping

# login to post own poem
pplog.login

poem = <<EOF
ぬ
ん
EOF
pplog.post(poem)

# Loop to browse other users poem
def loop_zap(pplog)
  loop do
    p pplog.zapping
    sleep 12
  end
end
