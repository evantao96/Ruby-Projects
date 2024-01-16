class CreateStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :statuses do |t|
      t.string :text
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
