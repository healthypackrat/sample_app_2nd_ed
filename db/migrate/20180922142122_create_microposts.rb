class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.string :content
      t.references :user, foreign_key: true

      t.timestamps

      t.index [:user_id, :created_at]
    end
  end
end
