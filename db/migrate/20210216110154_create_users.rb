# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, default: '', null: false
      t.integer :gender
      t.date :birthday

      t.timestamps
    end
  end
end
