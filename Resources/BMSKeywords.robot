*** Settings ***
Documentation    keywords repo for BMS labor claims
Resource    ./PO/LandingPage.robot
Resource    ./PO/HomePage.robot

*** Keywords ***
Copy The Timesheet From Last Week And Submit Claim
    [Arguments]    @{loginCreds}
    Go To Labor Claim Landing Page And Perform Login    @{loginCreds}
    Copy And Submit Labor From Last Week


Go To Labor Claim Landing Page And Perform Login
    [Arguments]    @{loginCreds}
    LandingPage.Navigate To Login Screen
    LandingPage.Perform Login To Labor Claim Portal     @{loginCreds}

Copy And Submit Labor From Last Week
    HomePage.Verify Home Page Loaded
    HomePage.Proceed To Current Week Claim