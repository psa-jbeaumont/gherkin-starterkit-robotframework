#language: fr
Fonctionnalité:  ACME - s'authentifier
    *En tant que* utilisateur ACME
    *Je souhaite* m'authentifier
    *Afin* d'être connecté à mon compte

    @ACME @CU00
    Plan du Scénario: S'authentifier avec succès
        Voici la documentation du scénario.

        Elle peut etre multi-lignes.

        Elle peut contenir des informations issues des exemples sur le scénario 
        par exemple "<profil>" utilisé pour l'authentification.

    Étant donné Un utilisateur avec le profil "<profil>"
    Lorsque l'utilisateur s'authentifie avec des identifiants valides
    Alors l'utilisateur doit être connecté

    Exemples:
        | profil         |
        | invité         |
        | administrateur |
