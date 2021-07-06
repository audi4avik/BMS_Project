*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${footerSection} =  //footer
${versionLink} =    //footer//div[starts-with(@class,'ds-col-xs-4')][3]/h5/a
${aboutText} =      id=mat-dialog-title-1
${fieldLabel} =    //table/tr/td/p/b
${fieldValue} =    //table/tr/td/p


*** Keywords ***
Locate The Elements And Validate
    wait until page contains element    ${versionLink}    timeout=10s
    execute javascript    window.scrollTo(0,document.body.scrollHeight)
    click element    ${versionLink}
    wait until page contains element    ${aboutText}
    element text should be    ${aboutText}    About Time@IBM
    ${loopVar}    get element count    ${fieldLabel}
    ${loopVar}    evaluate    ${loopVar}+1
    set global variable    ${loopVar}


Write Extracted Data Into Word File
    [Arguments]    ${filepath}
    ${docPresent}    run keyword and return status    file should exist    ${filepath}
    IF    ${docPresent}==False
    create file    ${filepath}
    Write Data Into File    ${filepath}
    ELSE
    Write Data Into File    ${filepath}
    END

Write Data Into File
    [Arguments]    ${filepath}
    FOR    ${index}    IN RANGE    1    ${loopVar}
           ${labelValue}   get text    (${fieldValue})[${index}]
           append to file    ${filepath}   ${labelValue}
    END