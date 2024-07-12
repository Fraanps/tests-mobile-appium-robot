*** Settings ***
Documentation    Arquivo principal do projeto de testes automatizados para Mobile

Library     AppiumLibrary
Library     JSONLibrary
Library     libs/Database.py
Resource    actions/Account.resource
Resource    actions/Login.resource
Resource    actions/Mybody.resource
Resource    actions/Menu.resource
Resource    actions/Popup.resource



*** Keywords ***
Start session
    # capabilities
    Open Application    http://localhost:4723
    ...    platformName=Android
    ...    automationName=UIAutomator2
    ...    deviceName=Emulator
    ...    udid=emulator-5554
    ...    app=${EXECDIR}/app/smartbit-beta.apk
    ...    autoGrantPermissions=true     #aceitando as permissões
    
    Wait Until Page Contains    IP da API    30

Finish session
    Capture Page Screenshot
    Close Application

Get Json fixture
    [Arguments]        ${scenario}

    ${data}    Load Json From File
    ...    ${EXECDIR}/resources/fixtures/data.json
    ...    encoding=utf-8

    RETURN    ${data}[${scenario}]

