*** Settings ***
Documentation    Camada de integração com a API

Library               RequestsLibrary

*** Keywords ***
Set user token
    ${payload}=    Create Dictionary    email=sac@smartbit.com    password=pwd123
    ${resp}=       POST    http://localhost:3333/sessions    json=${payload}
    Log            ${resp.json()}
    ${token}=      Set Variable    ${resp.json()}[token]
    Log            ${token}
    
    Set Suite Variable    ${TOKEN}    ${token}

Get account by name
    [Arguments]    ${account_name}
    ${params}=    Create Dictionary    name=${account_name}
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}

    ${resp}    GET
    ...    url=http://localhost:3333/accounts
    ...    params=${params}
    ...    headers=${headers}
    RETURN    ${resp.json()}[data][0]
        
