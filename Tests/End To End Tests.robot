*** Settings ***
Documentation   This is the test suite for claiming time@ibm
Resource    ../Resources/BMSKeywords.robot
Resource    ../Resources/Common.robot
Resource    ../Input/InputData.robot

Test Setup      Common.Begin Test       ${browser}    ${baseUrl}
Test Teardown   Common.Begin Teardown

*** Test Cases ***
Enter BMS Data From Previous Week With Zero Hours
    [Tags]    previous
    [Documentation]    Test case for copying from previous week functionality
    BMSKeywords.Copy The Timesheet From Last Week And Submit Claim      @{loginCreds}

