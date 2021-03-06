class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.string 			:name
    	t.text 				:description
    	t.float				:price, precision: 8, scale: 2
    	t.integer			:category_id

      t.timestamps null: false
    end
  end
end
