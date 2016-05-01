class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string  :title_section       
      t.string  :q_section       
      t.string  :a_section
      t.string  :b_section
      t.string  :c_section
      t.string  :d_section       
      t.text    :e_section
      t.string  :f_section 
      t.timestamps null: false
    end
  end
end
