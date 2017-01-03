class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :task
      t.integer :user_id
      t.integer :list_id

      t.timestamps
    end
  end
end
