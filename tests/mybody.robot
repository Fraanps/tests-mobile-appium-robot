*** Settings ***
Documentation    Suite de testes da funcioanlidade de cadastro de medidas no aplicativo android

Resource              ../resources/Base.resource
Library               RequestsLibrary

Test Setup       Start Session
Test Teardown    Finish Session

*** Test Cases ***
Deve poder cadastrar minhas medidas
    
    ${data}    Get Json Fixture    update_medidas
    Insert Membership    ${data}

    Signin With Document    ${data}[account][cpf]
    User Is Logged In

    Touch my body

    Wait Until Page Contains    Registre ou atualize suas medidas    5
    Send weight and height    ${data}[account]

    Popup Have Text    Seu cadastro foi atualizado com sucesso

    # checkando na API
    Set User Token
    ${account}    Get Account By Name    ${data}[account][name]
    Should Be Equal    ${account}[weight]    ${data}[account][weight]
    Should Be Equal    ${account}[height]    ${data}[account][height]



    
    

    
    
    
    
