class Renderer < Pixo::Renderer
  include ActiveModel::Model
  extend ActiveModel::Model

  def self.instance
    @renderer ||= Renderer.new
  end

  def self.started?
    @renderer.present?
  end

  def update(vals)
    vals.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  def on_key(key, scancode, action, mods)
    if (key == 257 && scancode == 36 && action == 1)
      self.pattern = Pattern.active.random.first
    end
  end

  def pattern_id
    pattern.id
  end

  def pattern_id=(id)
    self.pattern = Pattern.find(id)
  end

  def pattern=(pattern)
    super(pattern.name)
  end

  def pattern
    Pattern.find_by_name!(super)
  end

  def leds_on=(val)
    super(ActiveRecord::Type::Boolean.new.deserialize(val))
  end

  def persisted?
    true
  end

  private
  def initialize
    super
    add_fadecandy(ENV['PIXO_FADECANDY'] || 'localhost', 8)

    Pattern.active.each do |pattern|
      add_pattern(pattern.name, pattern.code)
    end

    self.pattern = Pattern.active.random.first
  
    @pattern_changer = Concurrent::TimerTask.new(execution_interval: 600, timeout_interval: 5) do
      self.pattern = Pattern.where(active: true).order("RANDOM()").first
    end.execute
  end
end