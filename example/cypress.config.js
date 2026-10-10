const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    supportFile: "cypress/support/e2e.js",
    video: false,
    async setupNodeEvents(on, config) {
      const { allureCypress } = await import("allure-cypress/reporter");
      allureCypress(on, config, { resultsDir: "allure-results" });
      return config;
    },
  },
});
