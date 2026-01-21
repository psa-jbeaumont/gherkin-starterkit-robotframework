*** Settings ***
Documentation       Les étapes des features file authentification
...
...                 On utilise la librairie gherkin-parser
...                 https://github.com/robotcodedev/robotframework-gherkin-parser

Library     ../../lib/GherkinDatatableConverter.py  AS  Datatable
Library     ../../lib/StepsLogger.py
Resource    ../../resources/WEB_DS/services/acme_service.resource
Resource    ../../resources/socle/dataset_socle.resource
Resource    hooks.resource

*** Variables ***
${a_user}  ${EMPTY}

*** Keywords ***
Un Utilisateur Avec Le Profil "${profil_utilisateur}"
  [Documentation]    L'utilisateur avec le profil <profil_utilisateur> se connecte sur l'application Démarches simplifiées (DS)
  ...    Cette étape commence avec l'ouverture de navigateur et se termine sur la page liste des dossiers de l'usagé
  ...    L'utilisateur est sélectionné grâce au fichier de données des utilisateurs en fonction du profil demandé
  ...
  ...    Paramètres :
  ...    - profil_utilisateur = ``le profil souhaité pour l'utilisateur`` (Obligatoire, pas de valeur défaut)
  ...
  ...    Exemples :
  ...    | un utilisateur connecté sur DS avec le profil "Usager"    | _--> Recherche du premier utilisateur avec le profil Usager, connexion sur DS en vue structure    _ |
  ...    | un utilisateur connecté sur DS avec le profil "Instructeur" | _--> Recherche du premier utilisateur avec le profil Instructeur, connexion sur DS en vue structure _ |
  ...
  ...    ---

  StepsLogger.Step  Connecter l'utilisateur avec le profil "${profil_utilisateur}" sur DS...

  ${a_user}=  dataset_socle.Obtenir Un Utilisateur Avec Le Profil "${profil_utilisateur}"
  Set Suite Variable  ${a_user}
      

  StepsLogger.Success  Je suis le user "${a_user}"

l'utilisateur s'authentifie avec des identifiants valides
  [Documentation]    L'agent sélectionne les critères de la recherche en vue structure et lance la recherche
  ...    Cette étape concerne uniquement la page vue structure
  ...    L'agent sélectionne les critères puis déclenche la recherche
  ...
  ...    Paramètres :
  ...    - rows = ``les critères de recherche de la vue structure`` (Obligatoire, pas de valeur défaut)
  ...    Si un critère est vide alors aucune sélection effectuée pour ce critère
  ...
  ...    _rows_ est un dictionnaire au format particulier founi par la parser feature file
  ...
  ...    - *TODO* construire un mot-clé pour convertir le format rows en un dictionnaire critere=valeur
  ...
  ...    Liste des critères vue structure :
  ...    | *critère*    | *format*    | *exemple*    |
  ...    | _structure_sie_ | <DIR>/<DIND>    | 450/0300    |
  ...    | _profil_    | Une seule valeur disponbile | Multi-défaillant |
  ...
  ...    Exemples :
  ...    | l'agent recherche les défaillances |    &{{{'rows': [{'cells': [{'value': 'structure_sie'}, {'value': 'profil'}]}, {'cells': [{'value': '450/0300'}, {'value': 'Multi-défaillant'}]}]}}} | _--> Recherche des dossiers avec le profil Multi-défaillant et la structure 450/0300    _ |
  ...
  ...
  ...    ---

  StepsLogger.Step  authentification :\n
  acme_service.Authentifier Utilisateur  ${a_user}

L'Utilisateur Doit Être Connecté
  [Documentation]    Vérifie que l'utilisateur est bien connecté sur l'application
  ...    Cette étape concerne uniquement la page dashboard après authentification
  ...    Le nom de l'utilisateur connecté doit être affiché
  ...
  ...    Paramètres : Aucun
  ...
  ...    Exemples :
  ...    | L'Utilisateur Doit Etre Connecté | _--> Lecture du nom de l'utilisateur connecté _ |
  ...
  ...    ---

  StepsLogger.Step  Vérification de la connexion de l'utilisateur...

  # Le niveau STEP est responsable de faire l'assertion
  #   Pour cela il construit une structure de données attendue comparable avec la structure retournée par le service layer

  # Préparer les données attendues de l'utilisateur connecté
  VAR  &{expected_user}=
  ...  role=${a_user}[role]
  ...  prenom=${a_user}[prenom]
  ...  nom=${a_user}[nom]

  # Obtenir le nom et le role affiché de l'utilisateur connecté dans un dictionnaire
  ${logged_user}=  acme_service.Obtenir L'Utilisateur Connecté

  # Le nom doit etre identique au nom de l'utilisateur courant
  Collections.Dictionaries Should Be Equal  ${logged_user}  ${expected_user}

  Set Test Message  Success: L'utilisateur est bien connecté avec les bonnes informations ${logged_user}==${expected_user}.
