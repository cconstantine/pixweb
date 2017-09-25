class Renderer < Pixo::Renderer
  include ActiveModel::Model
  extend ActiveModel::Model

  def self.instance
    @renderer ||= Renderer.new
  end

  def update(vals)
    vals.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  def pattern_id
    pattern.id
  end

  def pattern_id=(id)
    self.pattern = Pattern.find(id)
  end

  def pattern=(pattern)
    self.active_pattern = pattern.name
  end

  def pattern
    Pattern.find_by_name!(active_pattern)
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
  end
end