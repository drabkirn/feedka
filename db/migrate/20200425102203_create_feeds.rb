class CreateFeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :feeds do |t|
      t.text :content, null: false
      t.boolean :public, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
