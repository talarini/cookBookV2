class AddPortionToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :portion, :integer
  end
end
