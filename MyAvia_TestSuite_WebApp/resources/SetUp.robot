*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${URL}    https://practicetestautomation.com/practice-test-login/
${BROWSER}    chrome

*** Keywords ***
Setup Actions
   Open Browser    ${URL}    ${BROWSER}
   Set Global Variable    ${browser}    ${BROWSER}  
    Maximize Browser Window
    Log    Running tests on browser: ${BROWSER}
    Log    Browser opened and maximized
