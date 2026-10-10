# Cypress + Allure em Docker

[![Build e teste da imagem](https://github.com/lizarbventurim/docker_cypress-allure/actions/workflows/docker.yml/badge.svg)](https://github.com/lizarbventurim/docker_cypress-allure/actions/workflows/docker.yml)

Imagem Docker para rodar testes **Cypress** e gerar o relatório **Allure** com um único comando, sem instalar Node, Java, navegadores ou Allure na máquina. Serve para a sua máquina e para pipelines de CI.

## O que vem na imagem

- [`cypress/included`](https://github.com/cypress-io/cypress-docker-images/tree/master/included) com Cypress, Node.js e navegadores (Chrome, Firefox e Edge)
- Java (JRE) e [Allure Commandline](https://allurereport.org/) para gerar o relatório
- `entrypoint.sh`: instala as dependências do projeto, roda `cypress run` e **sempre gera o relatório**, mesmo quando há testes com falha, mantendo o código de saída do Cypress

As versões são fixas (Cypress e Allure) para que o build seja reproduzível, e o Dependabot abre PRs semanais para atualizá-las.

## Como usar

```bash
# construir a imagem
docker build -t cypress-allure .

# rodar os testes de um projeto Cypress (na pasta do projeto)
docker run --rm -v "$PWD":/e2e cypress-allure

# passar argumentos para o "cypress run"
docker run --rm -v "$PWD":/e2e cypress-allure --browser chrome --spec "cypress/e2e/login/**"
```

O relatório fica em `allure-report/` no seu projeto. Para abrir:

```bash
npx allure-commandline open allure-report
```

Com Docker Compose, a pasta `example/` é usada como projeto:

```bash
docker compose run --rm cypress
```

## Configurar o Allure no seu projeto

A versão do `cypress` no `package.json` do projeto precisa ser **a mesma da imagem** (argumento `CYPRESS_VERSION`), para o Cypress reaproveitar o binário já instalado.

```bash
npm install -D allure-cypress
```

`cypress.config.js`:

```js
const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    async setupNodeEvents(on, config) {
      const { allureCypress } = await import("allure-cypress/reporter");
      allureCypress(on, config, { resultsDir: "allure-results" });
      return config;
    },
  },
});
```

`cypress/support/e2e.js`:

```js
import "allure-cypress";
```

O diretório [`example/`](example) tem um projeto mínimo já configurado.

## Variáveis de ambiente

| Variável | Padrão | O que faz |
| --- | --- | --- |
| `ALLURE_RESULTS_DIR` | `allure-results` | pasta com os resultados do Allure |
| `ALLURE_REPORT_DIR` | `allure-report` | pasta do relatório HTML |
| `SKIP_INSTALL` | `false` | `true` não instala as dependências do projeto |
| `SKIP_REPORT` | `false` | `true` não gera o relatório |

Para outra versão do Cypress: `docker build --build-arg CYPRESS_VERSION=x.y.z -t cypress-allure .`

## Integração contínua

O workflow [`docker.yml`](.github/workflows/docker.yml) constrói a imagem, confere as versões instaladas, executa o projeto de exemplo dentro dela, verifica que o relatório foi gerado e o publica como artefato.

## Autor

**Lizarb Venturim**, Senior QA Engineer · [LinkedIn](https://www.linkedin.com/in/lizarbventurim/) · [Portfólio](https://lizarb.venturim.me)

Licença MIT.
