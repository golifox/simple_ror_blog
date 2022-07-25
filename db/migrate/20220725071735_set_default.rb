class SetDefault < ActiveRecord::Migration[7.0]
  def change
    change_column :users, 
      :post_count, :integer, default: 0
    change_column :users,
      :registration_date, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
end
