*** Settings ***
Documentation       Resource wrapper de la librairie 'Browser'
...                 Fournit des mots-clés communs pour l'automatisation web avec chrome
...                 Basé sur Browser et RPA.Desktop
...                 Ajoute la robustesse et permet la protection vis à vis des changements de Browser
...                 Permet la gestion des options de Chrome pour le téléchargement de fichiers

Library     DateTime
Library     String
Library     Browser

Resource    settings_socle.resource


*** Keywords ***
Ouvrir Navigateur Sur
  [Documentation]    Ouvrir le navigateur sur l'URL ciblé
  [Arguments]  ${url}

  ${options}=  Definir Options Pour Chrome

  # Gérer le mode headless
  #  HEADLESS est une variable d'exécution optionnelle du starter robot
  #  si non fournie, le mode headless est désactivé
  ${headless_bool}=  Convert To Boolean  %{HEADLESS_MODE=${False}}
  Browser.New Browser
  ...    browser=chromium
  ...    headless=${headless_bool}
  ...    args=${options}
  ...    executablePath=${SETTINGS}[chrome_binary_path]

  Browser.New Context
  ...    viewport={'width': 1920, 'height': 1080}
  ...    javaScriptEnabled=${TRUE}
  ...    recordVideo={'dir':'videos'}

  Browser.Set Browser Timeout    ${SETTINGS}[selenium_global_timeout]    scope=Test
  Browser.New Page    ${url}

Definir Options Pour Chrome
  [Documentation]        pour robot avec téléchargement de fichiers
  [Arguments]  ${dir_load}=${OUTPUTDIR}

  # Préparation des options de Chrome
  #   on utilise un template string pour passer les options
  #   par exemple {prefs} sera remplacé par le dictionnaire des préférences
  ${arguments_template}=  Create List
  ...  --no-sandbox
  ...  --disable-infobars
  ...  --disable-extensions
  ...  --disable-gpu
  ...  --disable-dev-shm-usage
  ...  --ignore-certificate-errors
  ...  --ignore-ssl-errors=yes
  ...  --window-size=1920,1080
  ...  --disable-logging
  ...  --log-level=3
  #...  al_option("prefs", {prefs})
  ...  --lang={locale}

  VAR  &{prefs}=
  # To turns off download prompt
  ...  download.prompt_for_download=${False}
  # Set download Directory
  ...  download.default_directory=${dir_load}
  # Avoid pdf viewer (désactivation de la visionneuse chrome)
  ...  plugins.always_open_pdf_externally=${True}

  ${chrome_options}=  String.Format String
  ...  ${arguments_template}
  ...  locale=fr-FR
  ...  prefs=${prefs}

  RETURN  ${chrome_options}

Obtenir Le Texte De L'Element
  [Documentation]    Obtenir le texte d'un élément ciblé
  [Arguments]  ${locator}

  L'Element Doit Etre Visible
  ...  locator=${locator}
  ${texte}=    Browser.Get Text    ${locator}

  RETURN  ${texte}

Aller Vers La Page
  [Documentation]   Directionner le navigateur vers une URL spécifique
  [Arguments]  ${url}

  Browser.Go To
  ...  url=${url}

L'Element Doit Etre Visible
  [Documentation]    Attendre que l'élément ciblé soit visible
  [Arguments]  ${locator}

  Browser.Wait For Elements State
  ...    selector=${locator}
  ...    state=visible

Saisir Dans Champ
  [Documentation]    Saisir du texte dans un champ
  [Arguments]  ${texte}
  ...  ${locator}

  L'Element Doit Etre Visible
  ...  locator=${locator}
  Browser.Type Text
  ...    selector=${locator}
  ...    txt=${texte}

Saisir Mot De Passe
  [Documentation]    Saisir un mot de passe
  [Arguments]  ${locator}
  ...  ${mot_de_passe}

  Set Log Level  level=NONE
  L'Element Doit Etre Visible
  ...  locator=${locator}
  Browser.Type Secret
  ...    selector=${locator}
  ...    secret=$mot_de_passe
  Set Log Level  level=TRACE

Cliquer Sur Element
  [Documentation]    Cliquer sur un élément
  [Arguments]  ${locator}

  L'Element Doit Etre Visible
  ...  locator=${locator}
  Browser.Click
  ...    selector=${locator}

Selectionner Element Dans Liste Deroulante
  [Documentation]    Sélectionner un élément dans une liste déroulante par sa valeur
  [Arguments]  ${locator}
  ...  ${valeur}

  L'Element Doit Etre Visible
  ...  locator=${locator}
  Browser.Select Options By    ${locator}    label    ${valeur}

Le Texte De L'Element "${locator}" Doit Etre "${expected}"
  [Documentation]    [MOCK] Vérifier que le texte de l'élément correspond à la valeur attendue

  ${text}=  web_socle.Obtenir Le Texte De L'Element  ${locator}
  Should Be Equal As Strings  ${text}  ${expected}

Appuyer Sur La Touche
  [Documentation]    Appuyer sur une touche du clavier
  [Arguments]  ${touche}

  # attendre que le focus soit sur la popup windows native Se Connecter
  Sleep  1s
  # Debug purpose
  # RPA.Desktop.Take Screenshot  embed=True
  # TODO RPA.Desktop.Press Keys  ${touche} 
  No Operation

Effectuer Une Capture D'Ecran
  [Documentation]    Effectuer une capture d'écran de l'élément ciblé (par défaut le body)
  [Arguments]  ${locator}=//body

  ${date}=  DateTime.Get Current Date
  ...  result_format=%d%m%Y_%H%M%S
  Browser.Take Screenshot
  ...  selector=${locator}
  ...  filename=${TEST_NAME}_${date}.png

Fermer Tous Les Navigateurs
  [Documentation]    Fermer tous les navigateurs ouverts

  Browser.Close Browser
