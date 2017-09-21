class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.text :usrname
      t.text :email
      t.text :message

      t.timestamps
    end
  end
end