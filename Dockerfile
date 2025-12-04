# Use a imagem base oficial do Cypress
FROM cypress/browsers:latest

# instala podman
USER root
RUN apt-get update && apt-get install -y podman

# Atualizar o repositório de pacotes e instalar pacotes necessários
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    git \
    default-jdk

# Atualizar os pacotes existentes e instalar as dependências necessárias
RUN apt-get update && apt-get install -y \
    wget \
    gnupg2 \
    ca-certificates \
    --no-install-recommends

RUN apt-get update && \
    apt-get install -y \
    libgtk2.0-0 \
    libgtk-3-0 \
    libgbm-dev \
    libnotify-dev \
    libnss3 \
    libxss1 \
    libasound2 \
    libxtst6 \
    xauth \
    xvfb \
    && apt-get clean   

# Limpar cache do apt-get para reduzir o tamanho da imagem
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar o Node.js    
RUN node --version
RUN npm --version    

# Exibe a versão do Java
RUN java -version 

# Instalar globalmente o allure-commandline
RUN npm install -g allure-commandline 

# Baixar e instalar o binário do Cypress
RUN npx cypress install

# Browserlist
RUN npx browserslist@latest

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /usr/src/app

# Expor uma porta (se o contêiner for servir uma aplicação)
EXPOSE 8080

# Script para personalizar comandos 
ENTRYPOINT ["./entrypoint.sh", "npx", "cypress", "run"]