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
${totalHours_45} =   //div[@row-id='1']//app-toggle-totals-renderer[@class='ng-star-inserted' and contains(text(),'45')]
${totalHours_0} =    //div[@row-id='2']//span[@class='ds-hide ng-star-inserted' and contains(text(),'0')]
${actionIcon} =     //div[@row-index='0']//mat-icon[@data-mat-icon-name='w3ds-more-filled-vertical-m']
${removeClaim} =    id=btn-claim-item-remove
${cpyPrevWeek} =    //a[@id='btn-copy-prev-week']
${prevWeekBox} =    css=div.cdk-overlay-pane
${zeroHrsMark} =    //span[text()='Zero hours']
${cpyLastWeekBtn} =   //button[text()='Ok']


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
    wait for condition    return document.readyState == "complete"    timeout=10s
    Check If Next Week Entry Is Already Present

Submit Labor Data For Current Week
    page should contain element    ${submitBtn}
    click element    ${submitBtn}
    wait until page contains element    ${submittedIcon}    timeout=10s


Check If Next Week Entry Is Already Present
    ${hours_45_Displayed}    run keyword and return status    element should be visible    ${totalHours_45}
    ${hours_0_Displayed}     run keyword and return status    page should contain element    ${totalHours_0}
    run keyword if    ${hours_45_Displayed}==True       Submit Labor Data For Next Week
    ...    ELSE IF     ${hours_0_Displayed}==True       Delete Time Entry And Proceed
    ...    ELSE        Copy From Previous Week With Zero Hours


Submit Labor Data For Next Week
    page should contain element    ${submitBtn}
    click element    ${submitBtn}
    wait until page contains element    ${submittedIcon}    timeout=10s

Delete Time Entry And Proceed
    click element    ${actionIcon}
    wait until element is visible    ${removeClaim}
    click element    ${removeClaim}
    Copy From Previous Week With Zero Hours

Copy From Previous Week With Zero Hours
    wait until element is visible    ${cpyPrevWeek}    timeout=10s
    click element    ${cpyPrevWeek}
    wait until element is visible    ${prevWeekBox}
    set focus to element    ${prevWeekBox}
    wait until element is visible    ${cpyLastWeekBtn}
    click element    ${cpyLastWeekBtn}
    wait until element is visible    ${saveBtn}
    click element    ${saveBtn}
