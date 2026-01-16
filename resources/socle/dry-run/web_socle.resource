*** Settings ***
Documentation       Mock de 'web_socle' - Version logs uniquement pour DRY_RUN
...                 Tous les keywords loggent l'action sans exécuter les appels SeleniumLibrary
...                 Permet la validation de scripts sans navigateur réel

Library     DateTime


*** Keywords ***
Ouvrir Navigateur Sur
  [Documentation]    [MOCK] Ouvrir le navigateur sur l'URL ciblé
  [Arguments]  ${url}

  Log  [MOCK] Ouverture du navigateur sur ${url}  level=INFO

Definir Options Pour Chrome
  [Documentation]    [MOCK] Définir les options pour Chrome
  [Arguments]  ${dir_load}=${OUTPUTDIR}

  Log  [MOCK] Configuration des options Chrome avec répertoire ${dir_load}  level=INFO
  RETURN  [MOCK_OPTIONS]

Obtenir Le Texte De L'Element
  [Documentation]    [MOCK] Obtenir le texte d'un élément ciblé
  [Arguments]  ${locator}

  Log  [MOCK] Récupération du texte de l'élément ${locator}  level=INFO
  RETURN  [MOCK_TEXT_FROM_${locator}]

Aller Vers La Page
  [Documentation]   [MOCK] Directionner le navigateur vers une URL spécifique
  [Arguments]  ${url}

  Log  [MOCK] Navigation vers ${url}  level=INFO

L'Element Doit Etre Visible
  [Documentation]    [MOCK] Attendre que l'élément ciblé soit visible
  [Arguments]  ${locator}

  Log  [MOCK] Vérification de la visibilité de l'élément ${locator}  level=INFO

Saisir Dans Champ
  [Documentation]    [MOCK] Saisir du texte dans un champ
  [Arguments]  ${texte}
  ...  ${locator}

  Log  [MOCK] Saisie de '${texte}' dans le champ ${locator}  level=INFO

Saisir Mot De Passe
  [Documentation]    [MOCK] Saisir un mot de passe
  [Arguments]  ${locator}
  ...  ${mot_de_passe}

  Log  [MOCK] Saisie du mot de passe dans ${locator}  level=INFO

Cliquer Sur Element
  [Documentation]    [MOCK] Cliquer sur un élément
  [Arguments]  ${locator}

  Log  [MOCK] Clic sur l'élément ${locator}  level=INFO

Selectionner Element Dans Liste Deroulante
  [Documentation]    [MOCK] Sélectionner un élément dans une liste déroulante par sa valeur
  [Arguments]  ${locator}
  ...  ${valeur}

  Log  [MOCK] Sélection de '${valeur}' dans la liste ${locator}  level=INFO

Le Texte De L'Element "${locator}" Doit Etre "${expected}"
  [Documentation]    [MOCK] Vérifier que le texte de l'élément correspond à la valeur attendue

  Log  [MOCK] Vérification que le texte de l'élément ${locator} est égal à '${expected}'  level=INFO

Appuyer Sur La Touche
  [Documentation]    [MOCK] Appuyer sur une touche du clavier
  [Arguments]  ${touche}

  Log  [MOCK] Appui sur la touche ${touche}  level=INFO

Effectuer Une Capture D'Ecran
  [Documentation]    [MOCK] Effectuer une capture d'écran de l'élément ciblé
  [Arguments]  ${locator}=//body

  Log  [MOCK] Capture d'écran de l'élément ${locator}  level=INFO

Fermer Tous Les Navigateurs
  [Documentation]    [MOCK] Fermer tous les navigateurs ouverts

  Log  [MOCK] Fermeture de tous les navigateurs  level=INFO
