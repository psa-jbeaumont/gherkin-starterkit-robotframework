*** Settings ***
Documentation       Les étapes des features file dossier
...
...                 On utilise la librairie gherkin-parser
...                 https://github.com/robotcodedev/robotframework-gherkin-parser

Library     ../../lib/GherkinDatatableConverter.py  AS  Datatable
Resource    ../../resources/WEB_DS/services/dossier_service.resource
Resource    ../../resources/socle/dataset_socle.resource
Resource    hooks.resource


*** Keywords ***
Un Utilisateur Connecté Sur DS Avec Le Profil "${profil_utilisateur}"
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

  Log To Console  Connecter l'utilisateur avec le profil "${profil_utilisateur}" sur DS...

  ${a_user}=  dataset_socle.Obtenir Un Utilisateur Avec Le Profil "${profil_utilisateur}"
  dossier_service.Authentifier Utilisateur  ${a_user}

  Log To Console  Je suis connecté avec le user "${a_user}"

Lorsque l'usager accède à son dossier
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

  Log To Console  Rechercher les défaillances avec les critères :\n

le résumé du dossier doit être présent
  [Documentation]    Depuis le vue structure, le tableau des dossiers doit contenir au moins une ligne
  ...    Cette étape concerne uniquement la page vue structure
  ...    Le nombre de dossiers est obtenu à partir du compteur visible sur la page
  ...
  ...    Paramètres : Aucun
  ...
  ...    Exemples :
  ...    | la liste des dossiers doit contenir au moins un élément | _--> Lecture du compteur de dossier par exemple 146 _ |
  ...
  ...    ---

  Log To Console  J'ai trouvé un élément

  Set Test Message  Success: un élément trouvé

l'usager recherche les défaillances
  [Documentation]    L'agent sélectionne les critères de la recherche en vue relances de la structure et lance la recherche.
  ...    Cette étape concerne uniquement la page vue relances de la structure.
  ...    L'agent sélectionne les critères puis déclenche la recherche.
  ...
  ...    Paramètres :
  ...    - rows = ``les critères de recherche de la vue relances de la structure`` (Obligatoire, pas de valeur défaut)
  ...    Si un critère est vide alors aucune sélection effectuée pour ce critère
  ...
  ...    _rows_ est un dictionnaire au format particulier founi par la parser feature file
  ...    Le keyword _Convertir Les Donnees Du Tableau Du parser Gherkin En Dictionnaire_ se charge
  ...    de la conversion du format row en un dictionnaire critère=valeur
  ...
  ...    Liste des critères vue structure :
  ...    | *critère*                    | *format*                                                                                                                                                                                         | *exemple*                                                                               |
  ...    | _Date Relance Créée Purge_   | Mettre n'importe quelle valeur pour activer la purge                                                                                                                                             | OUI                                                                                     |
  ...    | _Date Début Relance Créée_   | format date jj/mm/aaaa                                                                                                                                                                           | 10/10/2010                                                                              |
  ...    | _Date Fin Relance Créée_     | format date jj/mm/aaaa                                                                                                                                                                           | 10/10/2010                                                                              |
  ...    | _Structure Compétente Purge_ | Mettre n'importe quelle valeur pour activer la purge                                                                                                                                             | OUI                                                                                     |
  ...    | _Structure Compétente_       | DIR=${DIR};CICB=${CICB};FON=${FON}                                                                                                                                                               | DIR=450;CICB=0300;FON=251                                                               |
  ...    | _Critères topo Purge_        | Mettre n'importe quelle valeur pour activer la purge                                                                                                                                             | OUI                                                                                     |
  ...    | _Critères topo_              | Pour France:      CHOIX_PAYS=${Critères topo}[CHOIX_PAYS];CODE_DEPARTEMENT=${Critères topo}[CODE_DEPARTEMENT];CODE_COMMUNE=${Critères topo}[CODE_COMMUNE];CODE_VOIE=${Critères topo}[CODE_VOIE]  | CHOIX_PAYS=FRANCE;CODE_DEPARTEMENT=35;CODE_COMMUNE=238;CODE_VOIE=A002                   |
  ...    |                              | Pour COM:         CHOIX_PAYS=${Critères topo}[CHOIX_PAYS];CODE_COM=${Critères topo}[CODE_COM];CODE_COMMUNE=${Critères topo}[CODE_COMMUNE]                                                        | CHOIX_PAYS=COM;CODE_COM=975;CODE_COMMUNE=004                                            |
  ...    |                              | Pour Etranger:    CHOIX_PAYS=${Critères topo}[CHOIX_PAYS];CODE_PAYS_ETRANGER=${Critères topo}[CODE_PAYS_ETRANGER]                                                                                | CHOIX_PAYS=ETRANGER;CODE_PAYS_ETRANGER=99102                                            |
  ...    | _Mode De Relance_            | Plusieurs codes possibles pour cocher ou décocher les checkbox (code à connaître) du mode de relance (107;108;106;109;110;111;113;112).Indiquer par '!'avant le code pour décocher (!107;!108)   | 107;108;!106;109;110;111;!113;112                                                       |
  ...    | _Statut De Relance_          | Plusieurs codes possibles pour cocher ou décocher les checkbox (code à connaître) du statut de relance (56;17).Indiquer par '!'avant le code pour décocher (!56;!17)                             | !56;17                                                                                  |
  ...
  ...    Exemples :
  ...    | l'agent recherche les relances de la structure |    &{{{'rows': [{'cells': [{'value': 'Structure Compétente'}, {'value': 'Mode De Relance'}]}, {'cells': [{'value': 'DIR=450;CICB=0300'}, {'value': '107;!108'}]}]}}}      | _--> Recherche des relances de structure avec la structure DIR=450;CICB=0300 et le mode de relance 107 coché et 108 décoché _ |
  ...
  ...
  ...    ---
  [Arguments]  ${rows}

  # Convertir les données du tableau du parser Gherkin en dictionnaire
  ${criteria_dict}=  Datatable.Convert Datatable To Dict  ${rows}
  log to console  L'agent recherche les relances de la structure avec les critères :\n${criteria_dict}
