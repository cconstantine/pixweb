

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
      if (active_pattern.elapsed > 10.minutes)
        self.active_pattern = random_pattern
      end
    end
    close
  end

  def active_pattern
    @active_pattern ||= random_pattern
  end

  def random_pattern
    Device.patterns[Device.patterns.keys.sample]
  end

  def active_pattern=(pattern)
    pattern.reset_start
    @active_pattern = pattern
  end

private
  def initialize()
    super
    self.running = true

    add_fadecandy(Pixo::Native::FadeCandy.new('pixo-8.local', 8))
  end
end
