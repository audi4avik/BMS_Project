*** Settings ***
Documentation    keywords repo for BMS labor claims
Resource    ./PO/LandingPage.robot
Resource    ./PO/HomePage.robot
Resource    ./PO/FooterSection.robot

*** Keywords ***
#High level keywords
Copy The Timesheet From Last Week And Submit Claim
    [Arguments]    @{loginCreds}
    Go To Labor Claim Landing Page And Perform Login    @{loginCreds}
    Copy And Submit Labor From Last Week

Extract The Release Notes And Write Into Word Doc
     [Arguments]  ${filepath}    @{loginCreds}
     Go To Labor Claim Landing Page And Perform Login    @{loginCreds}
     Go To Footer Section And Perform The Validation    ${filepath}


#Low level keywords
Go To Labor Claim Landing Page And Perform Login
    [Arguments]    @{loginCreds}
    LandingPage.Navigate To Login Screen
    LandingPage.Perform Login To Labor Claim Portal     @{loginCreds}

Copy And Submit Labor From Last Week
    HomePage.Verify Home Page Loaded
    HomePage.Proceed To Claim Labor


Go To Footer Section And Perform The Validation
    [Arguments]    ${filepath}
    HomePage.Verify Home Page Loaded
    FooterSection.Locate The Elements And Validate
    FooterSection.Check If Write File Already Exists    ${filepath}
    FooterSection.Write Data Into File    ${filepath}