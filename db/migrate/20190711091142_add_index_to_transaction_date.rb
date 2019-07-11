class AddIndexToTransactionDate < ActiveRecord::Migration[6.0]
  def change
    add_index :transactions, :date
  end
end
