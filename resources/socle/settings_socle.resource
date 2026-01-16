*** Settings ***
Documentation  Obtenir les éléments de configuration pour les tests
...            Basé sur un fichier YAML

Library     Collections
Library     ../../lib/ReporterLibrary.py


*** Variables ***
# Dictionnaire des paramètres globaux importer à l'exécution via --variablefile
&{SETTINGS}     &{EMPTY}
# Mode DRY RUN : si true, utilise web_socle_mock (logs uniquement sans navigateur)
${DRY_RUN}      false


*** Keywords ***
Obtenir L'Url A Partir Du Canal
  [Documentation]  Obtenir l'URL en fonction du canal (intradef, internet)
  [Arguments]  ${canal}=${SETTINGS}[canal_default]

  # Récupération de l'environnement à partir de la variable d'environnement MY_ENV ou des settings par défaut
  VAR  ${environment}=  %{MY_ENV=${SETTINGS}[environment_default]}
  # Récupération de l'URL à partir du dictionnaire de l'environnement identifié (par exemple INTEG)
  #  indirection: https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#variables-inside-variables
  ${end_point}=  Get From Dictionary  ${${environment}}  ${canal}

  RETURN  ${end_point}
