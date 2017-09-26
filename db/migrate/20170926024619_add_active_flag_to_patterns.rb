class AddActiveFlagToPatterns < ActiveRecord::Migration[5.1]
  def change
    add_column :patterns, :active, :boolean, default: true
    add_index  :patterns, :active 
  end
end
