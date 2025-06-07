*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${WELCOME_BANNER}    xpath=//h1[normalize-space(.)="Dashboard"]
${LOGOUT_BUTTON}     id=logout

*** Keywords ***
Verify Dashboard Loaded
    [Documentation]    Ensure the dashboard header is visible
    Wait Until Element Is Visible    ${WELCOME_BANNER}
    Element Should Contain           ${WELCOME_BANNER}    Dashboard

Logout From Dashboard
    [Documentation]    Click logout and wait for login form
    Click Button    ${LOGOUT_BUTTON}
    Wait Until Element Is Visible   id=login-form
