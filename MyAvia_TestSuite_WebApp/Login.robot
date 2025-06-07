*** Settings ***
Library           SeleniumLibrary
Resource          ./resources/SetUp.robot
Resource          ./resources/TearDown.robot

Test Setup       Setup Actions
Test Teardown    Teardown Actions

# Test Template     Perform Login for valid user

*** Variables ***
${USER_NAME}       id:username
${PASS_WORD}       id:password
${LOGIN_BUTTON}    id:submit

*** Test Cases ***
logon to portal for valid user
    [Tags]    Smoke_Test_Run_On_${browser}
    Perform Login for valid user    student    Password123
logon to portal for no credentials
    [Tags]    Smoke_Test_Run_On_${browser}
    Perform Login for no credentials
logon to portal for invalid user
    [Tags]    Smoke_Test_Run_On_${browser}
    Perform Login for invalid user     Password123
logon to portal for invalid password
    Perform Login for invalid password     student

*** Keywords ***
Perform Login for valid user
    [Arguments]    ${usn}    ${passc}
    Input Text      ${USER_NAME}    ${usn}
    Input Text      ${PASS_WORD}    ${passc}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains    Logged In Successfully
    Log    Capturing screenshot after successful login
    Capture Page Screenshot    ${TEST_NAME}_${browser}.png

Perform Login for no credentials
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains    Your username is invalid!
    Log    Capturing screenshot on login
    Capture Page Screenshot

Perform Login for invalid user
    [Arguments]     ${passc}
    Input Text      ${USER_NAME}    test1
    Input Text      ${PASS_WORD}    ${passc}
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains    Your username is invalid!
    Log    Capturing screenshot on login
    Capture Page Screenshot    ${TEST_NAME}_${browser}.png

Perform Login for invalid password
    [Arguments]     ${usn}
    Input Text      ${USER_NAME}    ${usn}
    Input Text      ${PASS_WORD}    test1
    Click Button    ${LOGIN_BUTTON}
    Wait Until Page Contains    Your password is invalid!
    Log    Capturing screenshot on login
    Capture Page Screenshot    ${TEST_NAME}_${browser}.png
