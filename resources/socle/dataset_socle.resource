*** Settings ***
Documentation       Obtenir les jeux de données pour les tests
...                 Basé sur un fichier YAML
...                 Fournit des mots-clés pour obtenir des utilisateurs en fonction de leur profil

Library         Collections
Library         ../../lib/StepsLogger.py
# Importer le fichier de dataset en fonction de l'environnement défini par la variable d'environnement MY_ENV 
#   ou si non défini depuis le settings, par exemple INTEG
Variables       ../../dataset/%{MY_ENV=${SETTINGS}[environment_default]}_dataset.yaml


*** Keywords ***
Obtenir Un Utilisateur Avec Le Profil "${profil_utilisateur}"
  [Documentation]    Obtenir un jeu de données utilisateur en fonction du profil demandé
  ...
  ...    Paramètres :
  ...    - profil_utilisateur = ``le profil souhaité pour l'utilisateur`` (Obligatoire, pas de valeur défaut)
  ...
  ...    Exemples :
  ...    | Obtenir Un Utilisateur Avec Le Profil "Usager"    | _--> Retourne le premier utilisateur avec le profil Usager _ |
  ...    | Obtenir Un Utilisateur Avec Le Profil "Instructeur" | _--> Retourne le premier utilisateur avec le profil Instructeur _ |
  ...
  ...    ---

  StepsLogger.Socle  Obtenir un jeu de données utilisateur avec le profil "${profil_utilisateur}"...
  # Itérer sur la liste des utilisateurs pour trouver le premier avec le profil demandé
  VAR  ${found_user}=  ${None}
  FOR  ${user}  IN  @{utilisateurs}
    IF  '${user}[profile]' == '${profil_utilisateur}'
      VAR  ${found_user}=  ${user}
      BREAK
    END
  END
  IF  ${found_user} is ${None}
    Fail  Aucun utilisateur trouvé avec le profil "${profil_utilisateur}"
  END
  StepsLogger.Success  Utilisateur trouvé : ${found_user}

  RETURN  ${found_user}
