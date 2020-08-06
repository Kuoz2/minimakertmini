# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_05_225022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "bnombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "cnombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "half_payments", force: :cascade do |t|
    t.string "mpnombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "pagomonto"
    t.integer "pagovuelto"
    t.bigint "half_payment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["half_payment_id"], name: "index_payments_on_half_payment_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "pcodigo"
    t.string "pdescripcion"
    t.string "pdetalle"
    t.binary "ppicture"
    t.integer "pvalor"
    t.boolean "pvactivacioncatalogo"
    t.bigint "category_id", null: false
    t.bigint "brand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "pactivado"
    t.bigint "stock_id"
    t.bigint "provider_id"
    t.integer "precio_provider"
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["provider_id"], name: "index_products_on_provider_id"
    t.index ["stock_id"], name: "index_products_on_stock_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "nombre_provider"
    t.string "rut_provider"
    t.string "web_provider"
    t.string "detalle_provider"
    t.string "direccion_provider"
    t.string "comuna_provider"
    t.integer "telefono_provider"
    t.integer "telefono_persona_provider"
    t.string "correo_provider"
    t.integer "contabilidad_provider"
    t.string "banco_provider"
    t.binary "factura_provider"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sales", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "voucher_id"
    t.bigint "payment_id"
    t.index ["payment_id"], name: "index_sales_on_payment_id"
    t.index ["voucher_id"], name: "index_sales_on_voucher_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "pstock"
    t.integer "pstockcatalogo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "stock_lost"
    t.integer "stock_security"
    t.bigint "provider_id"
    t.index ["provider_id"], name: "index_stocks_on_provider_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "jti"
    t.string "name_user"
    t.string "m_lastname"
    t.string "f_lastname"
    t.integer "p_contacts"
    t.string "address"
    t.string "rut_user"
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "voucher_details", force: :cascade do |t|
    t.integer "dvcantidad"
    t.integer "dvprecio"
    t.bigint "voucher_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_voucher_details_on_product_id"
    t.index ["voucher_id"], name: "index_voucher_details_on_voucher_id"
  end

  create_table "vouchers", force: :cascade do |t|
    t.integer "vnumerodebusqueda"
    t.integer "vtotal"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "payments", "half_payments"
  add_foreign_key "products", "brands"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "providers"
  add_foreign_key "products", "stocks"
  add_foreign_key "stocks", "providers"
  add_foreign_key "voucher_details", "products"
  add_foreign_key "voucher_details", "vouchers"
end
