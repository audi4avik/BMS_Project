*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${footerSection} =  //footer
${versionLink} =    //footer//div[starts-with(@class,'ds-col-xs-4')][3]/h5/a
${aboutText} =      css=h2#mat-dialog-title-1
${fieldLabel} =     //table/tr/td/p/b
${fieldValue} =     //table/tr/td/p


*** Keywords ***
Locate The Elements And Validate
    wait until page contains element    ${versionLink}    timeout=10s
    execute javascript    window.scrollTo(0,document.body.scrollHeight)
    click element    ${versionLink}
    wait until element is visible    ${aboutText}
    element text should be    ${aboutText}    About Time@IBM
    ${fieldCount}    get element count    ${fieldLabel}
    set global variable    ${fieldCount}


Check If Write File Already Exists
    [Arguments]    ${filepath}
    ${docPresent}    run keyword and return status    file should exist    ${filepath}
    IF    ${docPresent}==False
    create file    ${filepath}
    log    New file created    debug
    ELSE
    log    File already present    info
    END


Write Data Into File
    [Arguments]    ${filepath}
    FOR    ${index}    IN RANGE    1    ${fieldCount}+1
           ${labelValue}   get text    (${fieldValue})[${index}]
           append to file    ${filepath}   ${labelValue}\n
    END