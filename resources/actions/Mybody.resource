*** Settings ***
Documentation    Ações de elementos da tela de envio de medidas

Library    AppiumLibrary

*** Keywords ***
Send weight and height
    [Arguments]    ${account}
    Input Text
    ...    xpath=//android.widget.EditText[@resource-id="weight"]    ${account}[weight]
    
    Input Text
    ...    //android.widget.EditText[@resource-id="height"]    ${account}[height]
    
    Click Element    xpath=//android.widget.TextView[@text="Enviar minhas medidas"]
