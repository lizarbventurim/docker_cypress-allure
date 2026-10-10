describe("Página de exemplo", () => {
  beforeEach(() => {
    cy.visit("app/index.html");
  });

  it("exibe o título da página", () => {
    cy.title().should("eq", "Página de exemplo");
    cy.contains("h1", "Olá, QA").should("be.visible");
  });

  it("soma ao clicar no botão", () => {
    cy.get("#somar").click().click();
    cy.get("#total").should("have.text", "2");
  });
});
