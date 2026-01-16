*** Settings ***
Documentation       Les actions possibles de la page de connexion
...                 Page Object Model

Resource    web_socle.resource
Resource    vault_socle.resource


*** Variables ***
${URI}              /users/sign_in
&{XP_CONNEXION}
...                 titre=//div[@id="kc-header-wrapper"]
...                 user=//input[@id="username"]
...                 pswd=//input[@id="password"]
...                 sign_in=//*[@id="kc-login"]


*** Keywords ***
Aller Vers La Page Connexion
  [Documentation]    Ouvre la page de connexion
  ...
  ...    Paramètres : Aucun
  ...
  ...    Exemples :
  ...    | Aller Vers La Page Connexion | _--> Ouvre la page de connexion Connexion _ |
  ...
  ...    ---

  Log To Console  J'ouvre la page de connexion ...

  ${end_point}=  settings_socle.Obtenir L'Url A Partir Du Canal
  web_socle.Ouvrir Navigateur Sur  ${end_point}${URI}
  web_socle.Appuyer Sur La Touche  ESC
  Connexion_page.La Page Doit Etre Visible

La Page Doit Etre Visible
  [Documentation]    Vérifier que la page est visible
  ...    Obtenir le titre de la page et verifier avec l'attendu
  ...
  ...    Paramètres : Aucun
  ...
  ...    Exemples :
  ...    | La Page Doit Etre Visible    | _--> Vérifier le titre de la page login _ |
  ...
  ...    ---

  web_socle.L'Element Doit Etre Visible  ${XP_CONNEXION}[titre]
  ${title}=  web_socle.Obtenir Le Texte De L'Element  ${XP_CONNEXION}[titre]
  Log To Console  Je suis sur la page "${title}"

Renseigner Le Champ Email
  [Documentation]    Renseigne l'agent avec son identifiant
  ...
  ...    Paramètres :
  ...    - my_user = ``le code identifiant de l'agent`` (Obligatoire, pas de valeur défaut)
  ...
  ...    Exemples :
  ...    | Renseigner Le Champ Utilisateur | stephane.dupond | _--> Renseigne l'identifiant agent avec Stephne.dupond _ |
  ...
  ...    ---
  [Arguments]  ${my_user}

  Log To Console  Je renseigne l'identifiant de l'utilisateur "${my_user}"...
  web_socle.Saisir Dans Champ
  ...  texte=${my_user}
  ...  locator=${XP_CONNEXION}[user]

Renseigner Le Champ Mot De Passe
  [Documentation]    Renseigne l'agent avec son mot de passe
  ...
  ...    Paramètres : Aucun
  ...
  ...    Exemples :
  ...    | Renseigner Le Champ Mot De Passe | _--> Renseigne le mot de passe agent _ |
  ...
  ...    ---
  [Arguments]  ${my_user}

  Log To Console  Je renseigne le mot de passe de l'agent...

  # Stopper les traces pour rendre confidentiel
  ${before}=  Set Log Level  TRACE

  # Obtenir le mot de passe depuis le coffre-fort
  vault_socle.Get Secret By Username  ${my_user}

  # renseigner le mot de passe avec Selenium
  web_socle.Saisir Mot De Passe
  ...  locator=${XP_CONNEXION}[pswd]
  ...  mot_de_passe=${VAULT_AUTH_SECRET_ITEM}[password]

  Set Log Level  ${before}

Cliquer Sur Le Bouton Sign In
  [Documentation]    ...    Cliquer sur le bouton se connecter
  ...
  ...    Paramètres : Aucun
  ...
  ...    Exemples :
  ...    | Cliquer Sur Le Bouton Se Connecter    | _--> Clique sur le bouton "Se Connecter" _ |
  ...
  ...    ---

  Log To Console  Je clique sur le bouton "Se connecter"
  web_socle.Cliquer Sur Element  ${XP_CONNEXION}[sign_in]
