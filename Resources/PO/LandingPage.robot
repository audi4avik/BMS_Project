*** Settings ***
Documentation    This page holds objects for landing page and login screen
Library    SeleniumLibrary

*** Variables ***
${welcomeTxt} =    //p[@id='title']
${loginSection} =    css=div#credsDiv
${loginPageHead} =   css=p#title
${inputEmail} =     name=username
${inputPwd} =       name=password
${loginBtn} =       id=login-button


*** Keywords ***
Navigate To Login Screen
    wait until element is visible    ${welcomeTxt}
    click element    ${loginSection}

Perform Login To Labor Claim Portal
    [Arguments]    @{loginCreds}
    element text should be    ${loginPageHead}     Sign in with your w3id credentials
    input text        ${inputEmail}   ${loginCreds}[0]
    input password    ${inputPwd}     ${loginCreds}[1]
    click element     ${loginBtn}






