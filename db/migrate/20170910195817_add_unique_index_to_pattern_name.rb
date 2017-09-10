class AddUniqueIndexToPatternName < ActiveRecord::Migration[5.1]
  def change
    add_index :patterns, :name, unique: true
  end
end
