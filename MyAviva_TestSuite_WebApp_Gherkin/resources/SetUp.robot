*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${URL}    https://practicetestautomation.com/practice-test-login/


*** Keywords ***
Setup Actions
   Open Browser    ${URL}    chrome
    Maximize Browser Window
    Log    Browser opened and maximized
