# features/api_tests/list_comments.feature
Feature: Yorumları Listeleme API'si
  Bir blog gönderisine ait yorumların doğru bir şekilde listelenip listelenmediğini kontrol etmek.

  Scenario: Mevcut bir gönderiye ait yorumları başarıyla listeleme
    Given "1" ID'li gönderi sistemde mevcut
    When istemci, o gönderiye ait yorumları listelemek için istek atar
    Then HTTP yanıt durumu "200" olmalıdır
    And yanıtta gelen yorum listesi boş olmamalıdır
    And yanıttaki her yorum "body" ve "user" alanlarını içermelidir
