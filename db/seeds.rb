# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

q0 = Tax.create!(
            :tnombre => "Poma",
            :timpuesto => 19
)
q1 = Category.create!(
                 :cnombre => "Cervezas"
)

q2 = Brand.create!(
              :bnombre => "Puma"
)
q4 = Provider.create!(
                  :nombre_provider=> "poma",
                  :rut_provider => 172463703,
                  :web_provider => "dnaskjdasjk",
                  :detalle_provider => "ndaskjnd",
                  :direccion_provider => "djnaskjds",
                  :comuna_provider => "calama",
                  :telefono_provider => 516516,
                  :telefono_persona_provider => 11616,
                  :correo_provider => "kdasndlsa@dasdlsan.com",
                  :contabilidad_provider => 45616,
                  :banco_provider => "Estado"
)

q3 = Product.create!(
    :pcodigo => 112312321,
    :pactivado => true,
    :pdescripcion => "hola",
    :pdetalle => "un detalle",
    :pvalor => 12,
    :category_id =>  1,
    :pvactivacioncatalogo=> false,
    :ppicture => "YXNzZXRzL2ltYWdlcy9iZWVyLTMxMTA5MF8xMjgwLmpwZw==",
    :provider_id => 1,
    :precio_provider => 200,
    :tax_id => 1,
    :piva => 19,
    :brand_id => 1,
    :pvneto => 1000,
    :fecha_vencimiento => "2021-08-18",
    :stock => Stock.create!(
    :pstock => 100,
    :pstockcatalogo => 1,
    :stock_lost => 2,
    :stock_security=> 3,

),
     :date_expiration => DateExpiration.create!(
     :fecha_vencimiento => "2021-08-18",
     :cambio_fecha => false,
     :cantidad_cambiadas => 1,
     :stock_expiration => 10,
     :actualizado_stockm => true
        )
)

q4 = Stock.create!(
    :pstock => 100,
    :pstockcatalogo => 1,
    :stock_lost => 2,
    :stock_security=> 3,
    :product_id => 1
)

q5 = DateExpiration.create!(
    fecha_vencimiento:'2021-10-20',
    cambio_fecha: true,
    cantidad_cambiadas: 200,
    stock_expiration: 200,
    actualizado_stockm: true,
    product_id: 1
)

