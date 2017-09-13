require 'pixo'

require 'sinatra/base'
require 'sinatra/twitter-bootstrap'

puts Thread::current

$pixo = Pixo::Application.new

class App < Sinatra::Base
  register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    puts Thread::current
    $pixo.active_pattern = $pixo.random_pattern
    haml :index
  end
end

Thread.new do
  App.run!
  $pixo.running = false
end

$pixo.run