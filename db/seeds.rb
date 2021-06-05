# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



q1 = Product.create!(

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
    :pstock => 1,
    :pstockcatalogo => 1,
    :stock_lost => 2,
    :stock_security=> 3

)
)

q2 = Product.create!(

    :pcodigo => 213123,
    :pactivado => false,
    :pdescripcion => "hola",
    :pdetalle => "un detalle",
    :pvalor => 12,
    :category_id =>  1,
    :pvactivacioncatalogo=> true,
    :ppicture => "YXNzZXRzL2ltYWdlcy9iZWVyLTMxMTA5MF8xMjgwLmpwZw==",
    :provider_id => 1,
    :precio_provider => 231,
    :tax_id => 1,
    :piva => 19,
    :brand_id => 1,
    :pvneto => 21321,
    :fecha_vencimiento => "2021-06-30",
    :stock => Stock.create!(
        :pstock => 12,
        :pstockcatalogo => 13,
        :stock_lost => 21,
        :stock_security=> 32

    )
)

q4 = Product.create!(

    :pcodigo => 213123,
    :pactivado => false,
    :pdescripcion => "hola",
    :pdetalle => "un detalle",
    :pvalor => 12,
    :category_id =>  1,
    :pvactivacioncatalogo=> true,
    :ppicture => "YXNzZXRzL2ltYWdlcy9iZWVyLTMxMTA5MF8xMjgwLmpwZw==",
    :provider_id => 1,
    :precio_provider => 231,
    :tax_id => 1,
    :piva => 19,
    :brand_id => 1,
    :pvneto => 21321,
    :fecha_vencimiento => "2021-10-19",
    :stock => Stock.create!(
        :pstock => 12,
        :pstockcatalogo => 13,
        :stock_lost => 21,
        :stock_security=> 32

    )
)