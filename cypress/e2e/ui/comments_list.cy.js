// cypress/e2e/ui/comment_list.cy.js
describe('Yorum Listesi Arayüz Testi', () => {
    const baseUrl = 'http://localhost:3000';

    beforeEach(() => {
        // Testlerden önce veritabanını temizleyip yeniden doldur
        cy.exec('bin/rails db:seed RAILS_ENV=test');
    });

    it('Bir gönderiye ait yorumları listeler ve görüntüler', () => {
        const postId = 1;

        // 1. Yorumları listeleme sayfasına git
        cy.visit(`${baseUrl}/posts/${postId}`);
        cy.wait(1500); // Sayfanın yüklenmesi için bekle

        // 2. Yorumların ekranda göründüğünü doğrula
        cy.get('.comment').should('have.length.at.least', 1); // En az bir yorum olmalı
        cy.wait(1000);

        // 3. Her yorumun içeriğini ve yazarını kontrol et
        cy.get('.comment').each(($comment) => {
            cy.wrap($comment).find('.comment-body').should('be.visible');
            cy.wait(500);
            cy.wrap($comment).find('.comment-author').should('be.visible');
            cy.wait(500);
        });

        // 4. "Yorum Ekle" formunun göründüğünü doğrula
        cy.get('#new_comment').should('be.visible');
        cy.wait(1000);
    });
});
