class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :identity_no
      t.integer :lvl, :default => 1
      t.integer :exp, :default => 0
      t.boolean :admin, :default => false
      t.string :password_digest
      t.string :remember_digest
      t.integer :hp, default: 100
      t.integer :curr_hp, default: 100
      t.integer :mp, default: 30
      t.integer :curr_mp, default: 30
      t.integer :str, default: 10
      t.integer :agi, default: 10
      t.integer :vit, default: 10
      t.integer :int, default: 10
      t.integer :luck, default: rand(100)
      t.integer :sp, default: 3
      t.integer :hp_job, default: 0
      t.integer :mp_job, default: 0
      t.integer :str_job, default: 0
      t.integer :agi_job, default: 0
      t.integer :vit_job, default: 0
      t.integer :int_job, default: 0
      t.integer :hp_eqp, default: 0
      t.integer :mp_eqp, default: 0
      t.integer :str_eqp, default: 0
      t.integer :agi_eqp, default: 0
      t.integer :vit_eqp, default: 0
      t.integer :int_eqp, default: 0
      t.integer :job_id, default: 1
      t.string :clan, default: "Neutral"
      t.string :title
      t.integer :class_no
      t.integer :year
      t.integer :resource_pts, :default => 0
      t.integer :gold_pts, :default => 0
      t.string :eqp_head
      t.string :eqp_body
      t.string :eqp_boots
      t.string :eqp_wpn

      t.timestamps null: false
    end
  end
end
