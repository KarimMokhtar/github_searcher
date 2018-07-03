class CreateRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories do |t|
      t.integer :repo_id
      t.string :name
      t.string :owner
      t.string :owner_url
      t.string :html_url
      t.text :description
      t.integer :stargazers_count
      t.integer :watcher_count

      t.timestamps
    end
  end
end
