class Device < Pixo::Native::Application
  attr_accessor :running

  def self.run
    @runner ||= Thread.new do
      Device.instance.run
    end
    at_exit {
      Device.instance.running = false
      Device.runner.join
    }
  end

  def self.runner
    @runner
  end

  def self.instance
    @instance ||= Device.new
  end

  def self.patterns
    @patterns ||= HashWithIndifferentAccess.new

    return unless @instance

    Pattern.find_each do |pattern|
      @patterns[pattern.name] ||= Pixo::Native::Pattern.new(pattern.code)
    end
    @patterns
  end


  def run
    while(running && tick(active_pattern))
      if (active_pattern.elapsed > 30.seconds)
        self.active_pattern = random_pattern
      end
    end
  end

  def active_pattern
    @active_pattern ||= random_pattern
  end

  def random_pattern
    Device.patterns[Device.patterns.keys.sample]
  end

  def active_pattern=(pattern)
    @active_pattern = pattern
    @active_pattern.reset_start
  end

private
  def initialize()
    super
    self.running = true

    add_fadecandy(Pixo::Native::FadeCandy.new('pixo-8.local', 8))
  end
end

cconstantine@thinker:~/workplace/pixweb$ rails generate controller PatternController
      create  app/controllers/pattern_controller_controller.rb
      invoke  erb
      create    app/views/pattern_controller
      invoke  test_unit
      create    test/controllers/pattern_controller_controller_test.rb
      invoke  helper
      create    app/helpers/pattern_controller_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    coffee
      create      app/assets/javascripts/pattern_controller.coffee
      invoke    scss
      create      app/assets/stylesheets/pattern_controller.scss