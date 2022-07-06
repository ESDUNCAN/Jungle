

describe("home", () => {
  it("should navigate to home", () => {
    cy.visit("/");
  });
  it("There is 2 products on the page", () => {
    cy.get(".products article")
      .should("have.length", 2);
  });
  it("should click on a product", () => {
    cy.contains("Scented Blade").click()
  })
  it("should show the product description", () => {
    cy.contains("The Scented Blade is an extremely rare, tall plant and can be found mostly in savannas. It blooms once a year, for 2 weeks.").should("exist");
  });
});