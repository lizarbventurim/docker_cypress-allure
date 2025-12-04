# Cypress Docker Image with Allure Report

Este repositório contém um Dockerfile que cria uma imagem Docker, configurada para executar testes Cypress com relatórios do Allure. 

## Funcionalidades

- Baseada em **Cypress/browsers:latest**
- Instalação do **Podman** para gerenciamento de contêineres
- Instalação do **Allure Commandline** para geração de relatórios
- Configuração completa com dependências GUI (GTK, LibGBM, etc.)
- Suporte a browsers com Xvfb para execução headless
- Configurada para executar um script personalizado `entrypoint.sh` ao iniciar o contêiner

## Pré-requisitos

- Docker instalado no sistema

## Como construir a imagem

Para construir a imagem Docker, utilize o seguinte comando no diretório onde o Dockerfile está localizado:

```bash
docker build -t cypress-allure:latest .
```


## Como executar o contêiner

Uma vez que a imagem esteja construída, você pode executar o contêiner com o seguinte comando:

```bash
docker run -it -p 8080:8080 cypress-allure:latest
```


O contêiner expõe a porta 8080, que pode ser mapeada para a máquina host. Certifique-se de que o entrypoint.sh está configurado corretamente para iniciar a aplicação ou testes desejados.

## Estrutura do projeto

	•	Dockerfile: Define as instruções para construir a imagem.
	•	entrypoint.sh: Script de entrada personalizado que será executado quando o contêiner iniciar.
	•	app/: Diretório de exemplo que pode conter os arquivos do seu proje
    to.

## Instalações Incluídas

- **Podman** - Gerenciamento de contêineres
- **Java (default-jdk)** - Runtime Java
- **Node.js e npm** - Runtime JavaScript
- **Cypress** - Framework de testes E2E
- **Allure Commandline** - Geração de relatórios (instalado globalmente via npm)
- **Dependências GUI**: libgtk2.0-0, libgtk-3-0, libgbm-dev, libnotify-dev, libnss3, libxss1, libasound2, libxtst6
- **Ferramentas X11**: xauth, xvfb (para execução headless)
- **Utilitários**: curl, vim, git, wget, gnupg2, ca-certificates



## Comandos Úteis

```bash
# Verificar versões instaladas
node --version
npm --version
java -version
npx cypress version

# Instalar dependências do projeto
npm install

# Executar testes com Cypress
npx cypress run

# Gerar relatórios com Allure
allure generate
allure serve

# Atualizar lista de browsers suportados
npx browserslist@latest

# Verificar instalação do Podman
podman --version
```

## Personalização

Você pode modificar o entrypoint.sh para executar diferentes comandos ou scripts no início da execução do contêiner, de acordo com as necessidades do seu projeto.

## Autor

Este Dockerfile foi criado por [Lizarb Venturim] (lizarbpacheco@gmail.com).

## Licença

Este projeto está licenciado sob a MIT License.

Este `README.md` fornece uma visão geral do projeto, explicando como construir e executar o contêiner, bem como descrevendo as instalações e dependências incluídas. Certifique-se de ajustar as instruções conforme necessário para atender às necessidades específicas do seu projeto.