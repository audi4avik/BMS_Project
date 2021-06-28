*** Settings ***
Documentation    Common keywords for time@ibm tests
Library    SeleniumLibrary

*** Keywords ***
Begin Test
    [Arguments]    ${browser}    ${baseUrl}
    open browser    about:blank     ${browser}
    maximize browser window
    go to    ${baseUrl}

Begin Teardown
    delete all cookies
    close all browsers