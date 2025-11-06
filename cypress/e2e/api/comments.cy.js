// cypress/e2e/api/comments.cy.js
describe('Yorumlar API Testi', () => {
    const baseUrl = 'http://localhost:3000/api/v1';

    beforeEach(() => {
        // Testlerden önce veritabanını temizleyip yeniden doldurmak için
        // Rails'in seed komutunu Cypress üzerinden çalıştırabiliriz.
        cy.exec('bin/rails db:seed RAILS_ENV=test');
    });

    it('Bir gönderiye ait yorumları başarıyla listeler', () => {
        const postId = 1;

        cy.request('GET', `${baseUrl}/posts/${postId}/comments`).then((response) => {
            // 1. Yanıt durumunu kontrol et
            cy.wait(1000).then(() => expect(response.status).to.eq(200));

            // 2. Yanıtın bir dizi (array) olduğunu kontrol et
            cy.wait(1000).then(() => expect(response.body).to.be.an('array'));

            // 3. Dizinin boş olmadığını kontrol et
            cy.wait(1000).then(() => expect(response.body).to.not.be.empty);

            // 4. Dizideki her bir yorumun yapısını kontrol et
            response.body.forEach((comment) => {
                cy.wait(500).then(() => expect(comment).to.have.property('body'));
                cy.wait(500).then(() => expect(comment).to.have.property('user'));
                cy.wait(500).then(() => expect(comment.user).to.be.an('object')); // user'ın bir nesne olduğunu doğrula
            });
        });
    });
});
