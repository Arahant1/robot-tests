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
${HOME_TAB}        xpath=//li[@id="menu-item-43"]/a
${PRACTICE_TAB}    xpath=//*[@id="menu-item-20"]



*** Test Cases ***
Naviagte on Home page
    Perform Home Page Navigation    student    Password123
Navigate on Practice page 
    Perform Practice Page Navigation    student    Password123

*** Keywords ***
Perform Home Page Navigation
    [Arguments]    ${usn}    ${passc}
    Input Text      ${USER_NAME}    ${usn}
    Input Text      ${PASS_WORD}    ${passc}
    Click Button    ${LOGIN_BUTTON}
    Click Element    ${HOME_TAB}
    Wait Until Page Contains    Welcome to Practice Test Automation!
    Log    Capturing screenshot after successful Welcome
    Capture Page Screenshot    ${TEST_NAME}_${browser}.png

Perform Practice Page Navigation
    [Arguments]    ${usn}    ${passc}
    Input Text      ${USER_NAME}    ${usn}
    Input Text      ${PASS_WORD}    ${passc}
    Click Button    ${LOGIN_BUTTON}
    Click Element    ${PRACTICE_TAB}
    Wait Until Page Contains    Practice
    Log    Capturing screenshot after successful Pracice
    Capture Page Screenshot   ${TEST_NAME}_${browser}.png