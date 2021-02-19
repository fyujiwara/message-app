# frozen_string_literal: true

class CreateTargets < ActiveRecord::Migration[6.1]
  def change
    create_table :targets do |t|
      t.integer :type, null: false

      t.timestamps
    end
  end
end
