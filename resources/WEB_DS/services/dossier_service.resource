*** Settings ***
Documentation       Les parcours du dossier utilisateur
...                 Service Layer

Resource    ../pages/Connexion_page.resource
Resource    ../pages/Demarches_page.resource


*** Keywords ***
Authentifier Utilisateur
  [Documentation]    Ouvre le navigateur, Renseigne le formulaire d'authentification et se connecte
  ...
  ...    Paramètres :
  ...    - my_user = ``identifiant de l'utilisateur sous forme d'e_mail`` (Obligatoire, pas de valeur défaut)
  ...
  ...    Exemples :
  ...    | Authentifier Utilisateur | user1@dvelop.sample.fr | _--> Connecte l'utilisateur user1@dvelop.sample.fr _ |
  ...
  ...    ---
  [Arguments]  ${my_user}

  Log To Console  L'utilisateur se connecte avec son email "${my_user}[email]" ...

  Connexion_page.Aller Vers La Page Connexion
  Connexion_page.Renseigner Le Champ Email  ${my_user}[email]
  Connexion_page.Renseigner Le Champ Mot De Passe  ${my_user}[email]
  Connexion_page.Cliquer Sur Le Bouton Sign In
  Demarches_page.La Page Doit Etre Visible
