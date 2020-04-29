class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.text :content, null: false
      t.integer :status, default: 0
      t.text :message
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
