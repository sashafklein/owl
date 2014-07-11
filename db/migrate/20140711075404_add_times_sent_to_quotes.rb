class AddTimesSentToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :times_sent, :integer, default: 0
  end
end
