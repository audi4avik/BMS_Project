*** Settings ***
Documentation    This is the object repository for Home page
Library    SeleniumLibrary
Library    DateTime

*** Variables ***
${expectedUrl} =    https://time.ibm.com/week
${homeLogo} =       //div[@id='top-of-page']//img[@alt='Time@IBM']
${overlayDiv} =     id=cdk-overlay-0
${overlayClose} =   //div[@id='cdk-overlay-0']//button[text()='Close']
${saveIcon} =       //mat-icon[@data-mat-icon-name='w3ds-save']
${submittedIcon} =  //mat-icon[@data-mat-icon-name='w3ds-check-circle']
${leftCaret} =      //mat-icon[@data-mat-icon-name='w3ds-caret-left-m']
${rightCaret} =     //mat-icon[@data-mat-icon-name='w3ds-caret-right-m']
${saveBtn} =        id=btn-timesheet-save
${submitBtn} =      css=button#btn-timesheet-submit
${cpyPrevWeek} =    //a[@id='btn-copy-prev-week']
${prevWeekBox} =    css=div.cdk-overlay-pane
${zeroHrsMark} =    //span[text()='Zero hours']
${cpyLastWeekBtn} =    //div[@id='cdk-overlay-9']//button[text()='Ok']


*** Keywords ***
Verify Home Page Loaded
    wait until location is    ${expectedUrl}    timeout=15s
    page should contain element    ${homeLogo}

    wait for condition    return document.readyState == "complete"
    sleep    5s
    ${overlayFlag}    run keyword and return status    element should be visible    ${overlayDiv}
    IF    ${overlayFlag}==True
    click element    ${overlayClose}
    ELSE
    log    overlay is not visible
    END


Proceed To Current Week Claim
    #Check the status of the current week claim
    ${submitFlag}    run keyword and return status    page should contain element    ${submittedIcon}
    ${saveFlag}    run keyword and return status    page should contain element    ${saveIcon}

    #decision based on claim status
    run keyword if    ${submitFlag}==True    Go To Next Week And Save Hours
    ...    ELSE IF    ${saveFlag}==True      Submit Labor Data For Current Week
    ...    ELSE                              Copy From Previous Week With Zero Hours

Go To Next Week And Save Hours
    click element    ${rightCaret}

Submit Labor Data For Current Week
    click element    ${rightCaret}
    click element    ${rightCaret}
    # code to be moved after data checking is implemented for weekdays
    wait until element is visible    ${cpyPrevWeek}    timeout=10s
#    click element    ${submitBtn}
#    wait until page contains element    ${submittedIcon}    timeout=10s
    click element    ${cpyPrevWeek}
    wait until element is visible    ${prevWeekBox}
    set focus to element    ${prevWeekBox}
    wait until element is visible    ${cpyLastWeekBtn}
    click element    ${cpyLastWeekBtn}
    wait until element is visible    ${saveBtn}
    click element    ${saveBtn}

Copy From Previous Week With Zero Hours
    wait until element is visible    ${cpyPrevWeek}
    click element    ${cpyPrevWeek}
    wait until element is visible    ${prevWeekBox}
    click element    ${cpyLastWeekBtn}
    wait until element is visible    ${saveBtn}
    click element    ${saveBtn}
