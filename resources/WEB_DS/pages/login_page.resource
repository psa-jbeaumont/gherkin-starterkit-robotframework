*** Settings ***
Documentation       Les actions possibles de la page de login ACME Demo App
...                 Page Object Model pour https://demo.applitools.com/
...
...                 Cette resource contient les locators et keywords pour interagir
...                 avec le formulaire de connexion de l'application de démonstration ACME.

Library     ../../../lib/StepsLogger.py
Resource    web_socle.resource


*** Variables ***
${URI}              /
&{XP_LOGIN}
...                 uri=/
...                 logo=//a[@class='logo-w']//img
...                 titre_form=//h4[@class='auth-header']
...                 champ_username=//input[@id='username']
...                 champ_password=//input[@id='password']
...                 bouton_sign_in=//a[@id='log-in']
...                 checkbox_remember=//input[@class='form-check-input']
...                 label_remember=//label[@class='form-check-label']
...                 lien_twitter=//img[@src='img/social-icons/twitter.png']/parent::a
...                 lien_facebook=//img[@src='img/social-icons/facebook.png']/parent::a
...                 lien_linkedin=//img[@src='img/social-icons/linkedin.png']/parent::a


*** Keywords ***
Aller Vers La Page Login
    [Documentation]    Ouvre la page de login ACME Demo App
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Aller Vers La Page Login | _--> Ouvre la page de login de l'application ACME _ |
    ...
    ...    ---

    StepsLogger.Page    J'ouvre la page de login ACME Demo App...

    ${end_point}=    settings_socle.Obtenir L'Url A Partir Du Canal
    web_socle.Ouvrir Navigateur Sur    ${end_point}${URI}
    web_socle.Appuyer Sur La Touche    ESC
    Login_page.La Page Doit Etre Visible

La Page Doit Etre Visible
    [Documentation]    Vérifier que la page de login est visible
    ...    Vérifie la présence du logo et du titre du formulaire
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | La Page Doit Etre Visible    | _--> Vérifie que la page de login est affichée _ |
    ...
    ...    ---

    # web_socle.L'Element Doit Etre Visible    ${XP_LOGIN}[logo]
    web_socle.L'Element Doit Etre Visible    ${XP_LOGIN}[titre_form]
    ${titre}=    web_socle.Obtenir Le Texte De L'Element    ${XP_LOGIN}[titre_form]
    StepsLogger.Success   Je suis sur la page "${titre}"

Renseigner Le Champ Username
    [Documentation]    Renseigne le champ username avec l'identifiant utilisateur
    ...
    ...    Paramètres :
    ...    - username = ``l'identifiant de l'utilisateur`` (Obligatoire, pas de valeur défaut)
    ...
    ...    Exemples :
    ...    | Renseigner Le Champ Username | john.doe | _--> Renseigne le champ username avec john.doe _ |
    ...
    ...    ---
    [Arguments]    ${username}

    StepsLogger.Page    Je renseigne le username "${username}"...
    web_socle.Saisir Dans Champ
    ...    texte=${username}
    ...    locator=${XP_LOGIN}[champ_username]

Renseigner Le Champ Password
    [Documentation]    Renseigne le champ password avec le mot de passe
    ...
    ...    Paramètres :
    ...    - password = ``le mot de passe de l'utilisateur`` (Obligatoire, pas de valeur défaut)
    ...
    ...    Exemples :
    ...    | Renseigner Le Champ Password | MySecretP@ss | _--> Renseigne le mot de passe _ |
    ...
    ...    ---
    [Arguments]    ${password}

    StepsLogger.Page    Je renseigne le mot de passe...

    # Stopper les traces pour rendre confidentiel
    ${before}=    Set Log Level    TRACE

    # Renseigner le mot de passe avec Selenium
    web_socle.Saisir Mot De Passe
    ...    locator=${XP_LOGIN}[champ_password]
    ...    mot_de_passe=${password}

    Set Log Level    ${before}

Cliquer Sur Le Bouton Sign In
    [Documentation]    Cliquer sur le bouton Sign in pour se connecter
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Bouton Sign In    | _--> Clique sur le bouton "Sign in" _ |
    ...
    ...    ---

    StepsLogger.Page    Je clique sur le bouton "Sign in"...
    web_socle.Cliquer Sur Element    ${XP_LOGIN}[bouton_sign_in]

Cocher La Case Remember Me
    [Documentation]    Coche la case "Remember Me" pour mémoriser la connexion
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cocher La Case Remember Me    | _--> Coche la case "Remember Me" _ |
    ...
    ...    ---

    Log To Console    Je coche la case "Remember Me"...
    web_socle.Cliquer Sur Element    ${XP_LOGIN}[checkbox_remember]

Cliquer Sur Le Lien Twitter
    [Documentation]    Cliquer sur l'icône Twitter pour accéder au réseau social
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Lien Twitter    | _--> Clique sur l'icône Twitter _ |
    ...
    ...    ---

    Log To Console    Je clique sur le lien Twitter...
    web_socle.Cliquer Sur Element    ${XP_LOGIN}[lien_twitter]

Cliquer Sur Le Lien Facebook
    [Documentation]    Cliquer sur l'icône Facebook pour accéder au réseau social
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Lien Facebook    | _--> Clique sur l'icône Facebook _ |
    ...
    ...    ---

    Log To Console    Je clique sur le lien Facebook...
    web_socle.Cliquer Sur Element    ${XP_LOGIN}[lien_facebook]

Cliquer Sur Le Lien Linkedin
    [Documentation]    Cliquer sur l'icône LinkedIn pour accéder au réseau social
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Lien Linkedin    | _--> Clique sur l'icône LinkedIn _ |
    ...
    ...    ---

    Log To Console    Je clique sur le lien LinkedIn...
    web_socle.Cliquer Sur Element    ${XP_LOGIN}[lien_linkedin]

Le Logo Doit Etre Visible
    [Documentation]    Vérifier que le logo ACME est visible sur la page
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Le Logo Doit Etre Visible    | _--> Vérifie la présence du logo ACME _ |
    ...
    ...    ---

    Log To Console    Je vérifie que le logo ACME est visible...
    web_socle.L'Element Doit Etre Visible    ${XP_LOGIN}[logo]
