#!/usr/bin/env bash
# Executa o Cypress e gera o relatório Allure no final, mesmo quando há testes com falha.
#
# Variáveis opcionais:
#   ALLURE_RESULTS_DIR  pasta de resultados do Allure   (padrão: allure-results)
#   ALLURE_REPORT_DIR   pasta do relatório HTML         (padrão: allure-report)
#   SKIP_INSTALL=true   não instala as dependências do projeto
#   SKIP_REPORT=true    não gera o relatório Allure
set -uo pipefail

RESULTS_DIR="${ALLURE_RESULTS_DIR:-allure-results}"
REPORT_DIR="${ALLURE_REPORT_DIR:-allure-report}"

if [ "${SKIP_INSTALL:-false}" != "true" ] && [ -f package.json ]; then
  if [ -f package-lock.json ]; then
    npm ci --no-audit --no-fund || exit 1
  else
    npm install --no-audit --no-fund || exit 1
  fi
fi

# Resultados antigos não podem contaminar o relatório novo
rm -rf "$RESULTS_DIR" "$REPORT_DIR"

cypress run "$@"
status=$?

if [ "${SKIP_REPORT:-false}" != "true" ]; then
  if [ -d "$RESULTS_DIR" ] && [ -n "$(ls -A "$RESULTS_DIR" 2>/dev/null)" ]; then
    allure generate "$RESULTS_DIR" --clean -o "$REPORT_DIR" \
      && echo "Relatório Allure gerado em $REPORT_DIR (abra $REPORT_DIR/index.html por um servidor, ou use: allure open $REPORT_DIR)"
  else
    echo "Aviso: nenhum resultado do Allure em $RESULTS_DIR. O plugin allure-cypress está configurado?" >&2
  fi
fi

exit $status
