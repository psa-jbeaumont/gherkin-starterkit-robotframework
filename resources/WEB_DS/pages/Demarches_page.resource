*** Settings ***
Documentation       Les actions possibles de la page liste des démarches
...                 Page Object Model

Resource    web_socle.resource
Resource    vault_socle.resource


*** Variables ***
${URI}          /procedures
&{XP_DOSSIERS}
...             titre=//*[@class="page-title"]


*** Keywords ***
Aller Vers La Page Liste Des Dossiers
  [Documentation]    Ouvre la page liste des dossiers
  ...
  ...    Paramètres : Aucun
  ...
  ...    Exemples :
  ...    | Aller Vers La Page Liste Des Dossiers | _--> Ouvre la page liste des dossiers _ |
  ...
  ...    ---

  Log To Console  J'ouvre la page liste des dossiers...

  ${end_point}=  setings_socle.Obtenir L'Url A Partir Du Canal
  web_socle.Aller Vers La Page  ${end_point}${URI}
  Demarches_page.La Page Doit Etre Visible

La Page Doit Etre Visible
  [Documentation]    Vérifier que la page est visible
  ...    Obtenir le titre de la page et verifier avec l'attendu
  ...
  ...    Paramètres : Aucun
  ...
  ...    Exemples :
  ...    | La Page Doit Etre Visible    | _--> Vérifier le titre de la page _ |
  ...
  ...    ---

  web_socle.L'Element Doit Etre Visible  ${XP_DOSSIERS}[titre]
  web_socle.Le Texte De L'Element "${XP_DOSSIERS}[titre]" Doit Etre "Démarches"

  Log To Console  Je suis sur la page "Démarches"
