*** Settings ***
Documentation    Suíte de teste de login

Resource    ../resources/Base.resource

Test Setup       Start Session
Test Teardown    Finish Session

*** Test Cases ***
Deve logar com o cpf e IP
    [Tags]    temp
    ${data}    Get Json Fixture    login
    
    Insert Membership    ${data}
    
    Signin With Document    ${data}[account][cpf]
    User is logged in

Não deve logar com cpf não cadastrado
    Signin With Document    03784017002
    Popup have text    Acesso não autorizado! Entre em contato com a central de atendimento

Não deve logar com cpf com digito inválido

    Signin With Document    00000014144
    Popup have text    CPF inválido, tente novamente

    

