*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn

*** Variables ***
${AUTH_URL}         https://test.api.amadeus.com
${TOKEN_ENDPOINT}   /v1/security/oauth2/token
${API_BASE}         https://test.api.amadeus.com
${CLIENT_ID}        BcLWSBNJDcuCUNkywGjfCmA5KVKuAqiy
${CLIENT_SECRET}    mGgKxFyBzBs9gTmP

*** Test Cases ***
Generate OAuth Token
    ${token}=    Generate Token
    Log    Access Token: ${token}    console=True

Flights Detail
    [Documentation]    Get payment link
    ${token}=    Generate Token
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${token}    Accept=application/json
    Create Session    amadeus    ${API_BASE}    headers=${auth_headers}
    
    ${query}=    Set Variable    originLocationCode=NYC&destinationLocationCode=LON&departureDate=2025-06-20&adults=1
    ${resp}=    GET On Session    amadeus    /v2/shopping/flight-offers?${query}
    Should Be Equal As Numbers    ${resp.status_code}    200
    
    ${flights}=    Set Variable    ${resp.json()}
    Log    Flight Offers Response: ${flights}

# Payment Link
#     Generate Payemnt Link

# Delete Payment Link

*** Keywords ***
Generate Token
    [Documentation]    Generate Token
    ${headers}=    Create Dictionary    Content-Type=application/x-www-form-urlencoded
    ${data}=       Set Variable    grant_type=client_credentials&client_id=${CLIENT_ID}&client_secret=${CLIENT_SECRET}

    Create Session    auth    ${AUTH_URL}    headers=${headers}
    ${resp}=    POST On Session    auth    ${TOKEN_ENDPOINT}    data=${data}
    Should Be Equal As Numbers    ${resp.status_code}    200

    ${json}=    Set Variable    ${resp.json()}
    ${token}=    Get From Dictionary    ${json}    access_token
    [Return]    ${token}
Generate Payemnt Link
    [Documentation]    Initiate a payment link for a booking
    ${token}=    Generate Token
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${token}    Content-Type=application/json
    Create Session    amadeus    ${API_BASE}    headers=${auth_headers}
    
    ${payment_payload}=    Create Dictionary
    ...    amount=217.74
    ...    currency=EUR
    ...    description=Flight booking payment
    ...    return_url=https://yourwebsite.com/payment/return
    ...    cancel_url=https://yourwebsite.com/payment/cancel

    ${resp}=    POST On Session    amadeus    /v1/payment-links    json=${payment_payload}
    Should Be Equal As Numbers    ${resp.status_code}    201
    
    ${payment_response}=    Set Variable    ${resp.json()}
    ${payment_link}=    Get From Dictionary    ${payment_response}    payment_link
    Log    Payment Link: ${payment_link}    console=True


