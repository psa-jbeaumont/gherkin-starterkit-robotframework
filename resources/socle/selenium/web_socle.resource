*** Settings ***
Documentation       Resource wrapper de la librairie 'SeleniumLibrary'
...                 Fournit des mots-clés communs pour l'automatisation web avec chrome
...                 Basé sur SeleniumLibrary et RPA.Desktop
...                 Ajoute la robustesse et permet la protection vis à vis des changements de SeleniumLibrary
...                 Permet la gestion des options de Chrome pour le téléchargement de fichiers

Library     DateTime
Library     String
Library     SeleniumLibrary
...             screenshot_root_directory=EMBED

Resource    settings_socle.resource


*** Keywords ***
Ouvrir Navigateur Sur
  [Documentation]    Ouvrir le navigateur sur l'URL ciblé
  [Arguments]  ${url}

  ${options}=  Definir Options Pour Chrome

  SeleniumLibrary.Open Browser
  ...  url=${url}
  # ...  remote_url=http://127.0.0.1:4444/wd/hub
  ...  browser=chrome
  ...  options=${options}
  SeleniumLibrary.Maximize Browser Window
  SeleniumLibrary.Set Selenium Timeout
  ...  value=${SETTINGS}[selenium_global_timeout]

Definir Options Pour Chrome
  [Documentation]        pour robot avec téléchargement de fichiers
  [Arguments]  ${dir_load}=${OUTPUTDIR}

  # Préparation des options de Chrome
  #   on utilise un template string pour passer les options
  #   par exemple {prefs} sera remplacé par le dictionnaire des préférences
  ${arguments_template}=  Catenate  SEPARATOR=;
  # ...  binary_location="{chrome_binary_path}"
  ...  add_argument("--no-sandbox")
  ...  add_argument("--disable-infobars")
  ...  add_argument("--disable-extensions")
  ...  add_argument("--disable-gpu")
  ...  add_argument("--disable-dev-shm-usage")
  ...  add_argument("--ignore-certificate-errors")
  ...  add_argument("--ignore-ssl-errors=yes")
  ...  add_argument("--window-size=1920,1080")
  ...  add_argument("--disable-logging")
  ...  add_argument("--log-level=3")
  ...  add_experimental_option("prefs", {prefs})
  ...  add_argument("--lang={locale}")
  ...  {headless_mode}

  # Gérer le mode headless
  #  HEADLESS est une variable d'exécution optionnelle du starter robot
  #  si non fournie, le mode headless est désactivé
  ${headless_bool}=  Convert To Boolean  %{HEADLESS_MODE=${False}}
  ${headless_mode}=  Set Variable If    ${headless_bool}
  ...        add_argument("--headless=new")
  ...        ${EMPTY}

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
  ...  chrome_binary_path=${SETTINGS}[chrome_binary_path]
  ...  headless_mode=${headless_mode}

  RETURN  ${chrome_options}

Obtenir Le Texte De L'Element
  [Documentation]    Obtenir le texte d'un élément ciblé
  [Arguments]  ${locator}

  L'Element Doit Etre Visible
  ...  locator=${locator}
  ${texte}=  SeleniumLibrary.Get Text
  ...  locator=${locator}

  RETURN  ${texte}

Aller Vers La Page
  [Documentation]   Directionner le navigateur vers une URL spécifique
  [Arguments]  ${url}

  SeleniumLibrary.Go To
  ...  url=${url}

L'Element Doit Etre Visible
  [Documentation]    Attendre que l'élément ciblé soit visible
  [Arguments]  ${locator}

  SeleniumLibrary.Wait Until Element Is Visible
  ...  locator=${locator}

Saisir Dans Champ
  [Documentation]    Saisir du texte dans un champ
  [Arguments]  ${texte}
  ...  ${locator}

  L'Element Doit Etre Visible
  ...  locator=${locator}
  SeleniumLibrary.Input Text
  ...  locator=${locator}
  ...  text=${texte}
  ...  clear=True

Saisir Mot De Passe
  [Documentation]    Saisir un mot de passe
  [Arguments]  ${locator}
  ...  ${mot_de_passe}

  Set Log Level  level=NONE
  L'Element Doit Etre Visible
  ...  locator=${locator}
  SeleniumLibrary.Input Password
  ...  locator=${locator}
  ...  password=${mot_de_passe}
  ...  clear=False
  Set Log Level  level=TRACE

Cliquer Sur Element
  [Documentation]    Cliquer sur un élément
  [Arguments]  ${locator}

  L'Element Doit Etre Visible
  ...  locator=${locator}
  SeleniumLibrary.Click Element
  ...  locator=${locator}

Selectionner Element Dans Liste Deroulante
  [Documentation]    Sélectionner un élément dans une liste déroulante par sa valeur
  [Arguments]  ${locator}
  ...  ${valeur}

  L'Element Doit Etre Visible
  ...  locator=${locator}
  SeleniumLibrary.Select From List By Value
  ...  ${locator}
  ...  ${valeur}

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
  # TODO RPA.Desktop.Press Keys  ${touche} non disponible sur grille selenium
  No Operation

Effectuer Une Capture D'Ecran
  [Documentation]    Effectuer une capture d'écran de l'élément ciblé (par défaut le body)
  [Arguments]  ${locator}=//body

  ${date}=  DateTime.Get Current Date
  ...  result_format=%d%m%Y_%H%M%S
  SeleniumLibrary.Capture Element Screenshot
  ...  locator=${locator}
  ...  filename=${TEST_NAME}_${date}.png

Fermer Tous Les Navigateurs
  [Documentation]    Fermer tous les navigateurs ouverts

  SeleniumLibrary.Close All Browsers
