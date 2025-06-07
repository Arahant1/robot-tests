*** Settings ***
Library      SeleniumLibrary
Library      ../lib/BDDLibrary.py
Resource     ../resources/SetUp.robot
Resource     ../resources/TearDown.robot
Resource     ../pages/LoginPage.resource
# Library    GherkinLibrary


Test Teardown    Teardown Actions
Test Setup       Setup Actions

# Test Template     Perform Login for valid user

# *** Variables ***
# ${USER_NAME}       id:username
# ${PASS_WORD}       id:password
# ${LOGIN_BUTTON}    id:submit

*** Test Cases ***
the app is on logon screen
    Login Page Should Be Open
the user enters valid credentials
    Enter username 
    Enter Password
    Click Login
the user shouls see home screen
    User See Home Screen

