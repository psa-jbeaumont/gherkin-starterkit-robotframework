*** Settings ***
Documentation    Hooks before and after suite and test execution

Resource    ../../resources/socle/vault_socle.resource


*** Keywords ***
before_test
  [Tags]  hook:before-test
  [Arguments]  ${context}=  ${test}=
  Log  before test ${context} - ${test}
  # Fail  har har test

after_test
  [Tags]  hook:after-test
  [Arguments]  ${context}=  ${test}=
  Log  after test

before_suite
  [Tags]  hook:before-suite
  [Arguments]  ${context}=  ${suite}=

  # Ouvrir la coffre-fort des secretsavant le début de la suite de tests
  vault_socle.Open Vault

after_suite
  [Tags]  hook:after-suite
  [Arguments]  ${context}=  ${test}=
  Log  after suite
