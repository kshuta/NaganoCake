# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Admin.create(email: 'a@a', password: '111111')

Genre.create([{name: "ケーキ", is_activated: true}])

Item.create([{genre_id: 1, name: "チョコケーキ", description: "美味しいチョコケーキ", untaxed_price: 300, is_in_stock: true}, {genre_id: 1, name: "ショートケーキ", description: "美味しいショートケーキ", untaxed_price: 300, is_in_stock: true}])

EndUser.create([{password: "111111", email: "s@s.com", last_name_kanji: "熊田", first_name_kanji: "柊太", last_name_kana: "クマダ", first_name_kana: "シュウタ", zip_code: "334334", address: "東京都港区1-1-1", phone_number: "0120555555"}])