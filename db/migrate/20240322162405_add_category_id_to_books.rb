class AddCategoryIdToBooks < ActiveRecord::Migration[7.1]
  def change
    add_reference :books, :category, foreign_key: true
  end
end
