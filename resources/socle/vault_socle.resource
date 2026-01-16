*** Settings ***
Documentation  Silently get secrets vault with keepass Library

Library     KeePassLibrary
Resource    settings_socle.resource


*** Variables ***
&{VAULT_AUTH_SECRET_ITEM}                                                                                   &{EMPTY}

&{VAULT_AUTH_KEEPASS}
# database path is relative to root folder, default to EXECDIR
...                                                                                                         database=%{ROBOT_DEPLOY=${EXECDIR}}/${SETTINGS}[vault_keepass_database]
# key_file path is relative to WORKSPACE or OUTPUTDIR
...                                                                                                         key_file=%{WORKSPACE=${OUTPUTDIR}}/${SETTINGS}[vault_keepass_keyfile]
# group name in keepass database, default to environment variable MY_ENV or settings.environment_default
...                                                                                                         group=%{MY_ENV=${SETTINGS}[environment_default]}


*** Keywords ***
Open Vault
  [Documentation]  Open keepass database with key_file

  # Begin secret section - silently get secret
  ${previous_loglevel}=  Set Log Level  NONE

  KeePasslibrary.Open Keepass Database
  ...  filename=${VAULT_AUTH_KEEPASS}[database]
  ...  keyfile=${VAULT_AUTH_KEEPASS}[key_file]

  # End secret section - go back to normal loglevel
  Set Log Level  ${previous_loglevel}

Get Secret By Username
  [Documentation]  Get secret by username and relative to environment (MY_ENV as a group)
  ...              Store it in KEEPASS_AUTH_SECRET_ITEM global variable
  [Arguments]  ${my_username}

  # get group from MY_ENV environment variable
  ${keepass_group}=  KeePassLibrary.Get Groups By Name
  ...  group_name=${VAULT_AUTH_KEEPASS}[group]
  ...  first=${TRUE}

  Should Be True  '''${keepass_group}''' != 'None'
  ...  msg=Le groupe ${VAULT_AUTH_KEEPASS}[group] n'existe pas dans le coffre-fort ${VAULT_AUTH_KEEPASS}[database]

  # get secret entry from keepass database
  ${keepass_entry}=  KeePassLibrary.Get Entries By Username
  ...  username=${my_username}
  ...  group=${keepass_group}
  ...  first=${TRUE}
  Should Be True
  ...  '''${keepass_entry}''' != 'None'
  ...  msg=L'utilisateur ${my_username} n'existe pas dans le groupe ${VAULT_AUTH_KEEPASS}[group] du coffre-fort ${VAULT_AUTH_KEEPASS}[database]
  # Begin secret section - silently get secret
  ${previous_loglevel}=  Set Log Level  TRACE

  ${secret_password}=  Get Entry Password  ${keepass_entry}
  ${bearer_b64}=  Evaluate  base64.b64encode('${my_username}:${secret_password}'.encode('utf-8'))  modules=base64

  # store secret in global dictionary
  VAR  &{VAULT_AUTH_SECRET_ITEM}=
  ...  username=${my_username}
  ...  password=${secret_password}
  ...  bearer=${bearer_b64}
  ...  scope=TEST

  # End secret section - go back to normal loglevel
  Set Log Level  ${previous_loglevel}
