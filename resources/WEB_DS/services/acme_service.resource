*** Settings ***
Documentation       Les parcours du dossier utilisateur
...                 Service Layer

Library     String
Library     ../../../lib/StepsLogger.py
Resource    ../pages/login_page.resource
Resource    ../pages/dashboard_page.resource


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

  StepsLogger.Service  L'utilisateur se connecte avec son email "${my_user}[email]" ...

  login_page.Aller Vers La Page Login
  login_page.Renseigner Le Champ Username  ${my_user}[email]
  login_page.Renseigner Le Champ Password  ${my_user}[email]
  login_page.Cliquer Sur Le Bouton Sign In
  dashboard_page.La Page Doit Etre Visible

Obtenir L'Utilisateur Connecté
  [Documentation]    Récupère les informations affichées de l'utilisateur actuellement connecté sur l'application
  ...
  ...    Paramètres : Aucun
  ...
  ...    Exemples :
  ...    | ${logged_user_name}=  Obtenir Le Nom De L'Utilisateur Connecté | _--> Récupère le nom affiché de l'utilisateur connecté _ |
  ...
  ...    ---

  StepsLogger.Service  Récupération du nom de l'utilisateur connecté...

  # Le niveau SERVICE est responsable de collecter les informations  observées à l'écran
  #   Pour cela il utilise les page objects pour interagir avec l'interface utilisateur
  #   Le service layer construit une structure de données comparable avec la structure attendue par le step layer
  ${logged_user_name}=  dashboard_page.Obtenir Le Nom De L'Utilisateur Connecté
  ${logged_user_role}=  dashboard_page.Obtenir Le Rôle De L'Utilisateur Connecté
  ${role}=  String.Convert To Lower Case  ${logged_user_role}
  ${firstname}  ${lastname}=  String.Split String  ${logged_user_name}  ${SPACE}  1

  VAR  &{logged_user}=
  ...  role=${role}
  ...  prenom=${firstname}
  ...  nom=${lastname}

  RETURN  ${logged_user}
