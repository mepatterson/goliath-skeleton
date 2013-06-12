# need to require this stuff so we can play with AR models in the migration
require 'goliath/goliath'
require 'goliath/runner'
require 'goliath/rack'
require 'globalize3'
Dir["./app/models/*.rb"].each { |f| require f }

class CreateUnlocks < ActiveRecord::Migration
  def up
    create_table :unlocks do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
    Unlock.create_translation_table!({ name: :string, description: :text })
  end

  def down
    drop_table :unlocks
    Unlock.drop_translation_table!
  end
end
