*** Settings ***
Documentation   This is the test suite for automating time@ibm
Resource    ../Resources/BMSKeywords.robot
Resource    ../Resources/Common.robot
Resource    ../Input/InputData.robot

Test Setup      Common.Begin Test       ${browser}    ${baseUrl}
Test Teardown   Common.Begin Teardown

# TODO  Add a custom python library
*** Test Cases ***
Enter BMS Data From Previous Week With Zero Hours
    [Tags]    previous
    [Documentation]    Test case for copying from previous week functionality with zero and actual hours
    BMSKeywords.Copy The Timesheet From Last Week And Submit Claim      @{loginCreds}

# robot -d results -i relnotes tests\end*robot
Validate Release note Details of Time@IBM And Store
    [Tags]    relnotes
    [Documentation]    This test case is to test version and release notes of time@ibm
    BMSKeywords.Extract The Release Notes And Write Into Word Doc   ${filepath}    @{loginCreds}

Validate The Error When Editing Data Of Locked Period
    [Tags]    Lock
    [Documentation]    Prior week locked labor should not be editable
    BMSKeywords.Locked Period Labor Edit Not Permitted    @{loginCreds}