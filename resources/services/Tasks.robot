*** Settings ***
Documentation    Arquivo para testar o consumo da API com tasks

Resource    ./Service.resource

*** Tasks ***
Testando a API
    Set User Token
    Get Account By Name    Ana Loise