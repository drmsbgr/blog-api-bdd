# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb
puts "Veriler siliniyor..."
User.destroy_all
Post.destroy_all
Comment.destroy_all
Tag.destroy_all

puts "Veriler oluşturuluyor..."
user1 = User.create!(name: "Ahmet", email: "ahmet@mail.com")
user2 = User.create!(name: "Zeynep", email: "zeynep@mail.com")

tag1 = Tag.create!(name: "rails")
tag2 = Tag.create!(name: "api")

post1 = user1.posts.create!(title: "İlk Yazım", content: "Bu bir Rails API denemesi.")
post1.tags << tag1
post1.tags << tag2

post2 = user2.posts.create!(title: "İkinci Yazı", content: "Modeller çok önemli.")
post2.tags << tag1

post1.comments.create!(body: "Harika yazı!", user: user2)
post2.comments.create!(body: "Katılıyorum.", user: user1)

puts "Veri oluşturma tamamlandı!"
