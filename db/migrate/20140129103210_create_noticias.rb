class CreateNoticias < ActiveRecord::Migration
  def change
    create_table :noticias do |t|
      t.string :titulo
      t.string :descricao
      t.datetime :data

      t.timestamps
    end
  end
end
