*** Settings ***
Library           SeleniumLibrary



# *** Variables ***
# ${URL}               https://example-webapp.com/login
# ${USERNAME_FIELD}    id=username
# ${PASSWORD_FIELD}    id=password
# ${LOGIN_BUTTON}      xpath=//button[@type="submit"]

*** Keywords ***
Login Page Should Be Open
    Wait Until Page Contains    Test login

Enter username
    Input Text    id=username    student

Enter Password
    Input Text    id=password    Password123
Click Login
    Click Button    xpath=//button[@type="submit"]
User See Home Screen
    Wait Until Page Contains    Your username is invalid!
    Capture Page Screenshot