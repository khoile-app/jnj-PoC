*** Settings ***
Documentation     Shared keywords and variables for this project.
Library           SeleniumLibrary
Library           EyesLibrary    runner=web    config=${EXECDIR}/applitools.yaml

*** Variables ***
${BROWSER}        chrome
${BASE_URL}       https://www.jnj.com/

*** Keywords ***
Open App
    Open Browser    ${BASE_URL}    ${BROWSER}
    Set Window Size    1400    1000

Close App
    Close Browser
