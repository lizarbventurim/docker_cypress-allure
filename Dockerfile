# syntax=docker/dockerfile:1

# Imagem oficial do Cypress com o binário e os navegadores (Chrome, Firefox e Edge) já instalados.
# Fixe a versão para builds reproduzíveis: docker build --build-arg CYPRESS_VERSION=x.y.z .
ARG CYPRESS_VERSION=16.1.1
FROM cypress/included:${CYPRESS_VERSION}

ARG ALLURE_COMMANDLINE_VERSION=2.46.1

LABEL org.opencontainers.image.title="cypress-allure" \
      org.opencontainers.image.description="Cypress com relatórios Allure prontos para uso" \
      org.opencontainers.image.source="https://github.com/lizarbventurim/docker_cypress-allure" \
      org.opencontainers.image.licenses="MIT"

# Java (necessário para o Allure) e utilitários, em uma única camada e sem cache do apt
RUN apt-get update \
    && apt-get install -y --no-install-recommends default-jre-headless git curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Allure Commandline com versão fixa
RUN npm install -g "allure-commandline@${ALLURE_COMMANDLINE_VERSION}" \
    && npm cache clean --force

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Projeto de testes montado aqui: docker run -v "$PWD":/e2e ...
WORKDIR /e2e

ENTRYPOINT ["entrypoint.sh"]
# Argumentos extras vão direto para o "cypress run", por exemplo: --browser chrome --spec "cypress/e2e/**"
CMD []
