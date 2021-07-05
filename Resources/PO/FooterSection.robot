*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${footerSection} =  //footer
${versionLink} =    //footer//div[starts-with(@class,'ds-col-xs-4')][3]/h5/a
${aboutText} =      css=h2#mat-dialog-title-1
${fieldLabel} =    //b[@_ngcontent-cfx-c192]
${fieldvalue} =    //b[@_ngcontent-cfx-c192]/following-sibling::node()

*** Keywords ***
Locate The Elements And Validate
    wait until page contains element    ${versionLink}    timeout=10s
    execute javascript    window.scrollTo(0,document.body.scrollHeight)
    click element    ${versionLink}
    wait until page contains element    ${aboutText}
    element text should be    ${aboutText}    About Time@IBM
    ${loopVar}    get element count    ${fieldLabel}
    [Return]    ${loopVar}


Write Extracted Data Into Word File
    [Arguments]    ${filepath}
    ${docPresent}    run keyword and return status    file should exist    ${filepath}/AboutTime.docx
    IF    ${docPresent}==False
    create file    ${filepath}/AboutTime.docx    UTF-8
    Write Data Into File    ${filepath}    ${loopVar}
    ELSE
    Write Data Into File    ${filepath}    ${loopVar}
    END

Write Data Into File
    [Arguments]    ${filepath}    ${loopVar}
    FOR    ${index}    IN RANGE    1    ${loopVar}+1
    ${labelName}    get text    ${fieldLabel}
    ${labelValue}   get text    ${fieldvalue}
    ${resultString}    catenate   separator=:${SPACE}    ${fieldLabel}    ${fieldvalue}
    append to file    ${filepath}/AboutTime.docx    ${resultString}
    END