*** Settings ***
Documentation     Verifies the Johnson & Johnson (jnj.com) homepage loads and its header navigation tabs work,
...               with Applitools Eyes visual checks at each navigation step.
Resource          ../resources/common.resource
Suite Setup       Open App
Suite Teardown    Close App
Test Setup        Go To Homepage
Test Teardown     Eyes Close Async

*** Test Cases ***
Homepage Loads Successfully
    [Documentation]    Verifies the jnj.com homepage loads and its body renders.
    Eyes Open    test_name=Homepage Loads Successfully
    Wait Until Element Is Visible    tag:body
    Sleep    2s
    Eyes Check Window    Homepage

Click Through Header Tabs
    [Documentation]    Clicks each header navigation tab (Healthcare areas, News, Investors, Careers, Our company),
    ...    waits for its mega-menu to render, and takes an Eyes Check at each step.
    Eyes Open    test_name=Click Through Header Tabs
    Wait Until Element Is Visible    tag:body
    Sleep    2s
    Eyes Check Window    Homepage
    FOR    ${tab}    IN    Healthcare areas    News    Investors    Careers    Our company
        Click Header Tab And Verify    ${tab}
    END

*** Keywords ***
Go To Homepage
    Go To    ${BASE_URL}
    Dismiss Cookie Banner If Present

Dismiss Cookie Banner If Present
    ${present} =    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    class:onetrust-close-btn-handler    timeout=5s
    IF    ${present}
        Click Element    class:onetrust-close-btn-handler
        Wait Until Element Is Not Visible    id:onetrust-banner-sdk    timeout=5s
    END

Click Header Tab And Verify
    [Arguments]    ${tab_text}
    ${tab_locator} =    Set Variable
    ...    xpath://span[contains(@class,'NavigationItem-text-value') and normalize-space(text())='${tab_text}']
    ${menu_button_locator} =    Set Variable
    ...    xpath://button[@aria-label='Open Sub Navigation for ${tab_text}']
    Wait Until Element Is Visible    ${tab_locator}
    Click Element    ${tab_locator}
    Wait Until Keyword Succeeds    5s    0.5s
    ...    Element Attribute Value Should Be    ${menu_button_locator}    aria-expanded    true
    Sleep    2s
    Eyes Check Window    ${tab_text}
