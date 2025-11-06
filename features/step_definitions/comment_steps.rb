# features/step_definitions/comment_steps.rb
require 'httparty'
require 'json'

Given('"1" ID\'li gönderi sistemde mevcut') do
  # Test verileri seeds.rb'den geldiği için bu adımda bir şey yapmamıza gerek yok.
  # Sadece senaryonun okunabilirliğini artırır.
  @post_id = 1
end

When('istemci, o gönderiye ait yorumları listelemek için istek atar') do
  base_url = "http://localhost:3000" # Rails sunucunuzun adresi
  @response = HTTParty.get("#{base_url}/api/v1/posts/#{@post_id}/comments")
end

Then('HTTP yanıt durumu "{int}" olmalıdır') do |status_code|
  expect(@response.code).to eq(status_code)
end

And('yanıtta gelen yorum listesi boş olmamalıdır') do
  @comments = JSON.parse(@response.body)
  expect(@comments).not_to be_empty
end

And('yanıttaki her yorum "body" ve "user" alanlarını içermelidir') do
  @comments.each do |comment|
    expect(comment).to have_key('body')
    expect(comment).to have_key('user')
    expect(comment['user']).to be_a(Hash) # user'ın da bir obje olduğunu doğrulayalım
  end
end
