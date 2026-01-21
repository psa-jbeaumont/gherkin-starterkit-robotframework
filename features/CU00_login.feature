#language: fr
Fonctionnalité:  ACME - s'authentifier
    *En tant que* utilisateur ACME
    *Je souhaite* m'authentifier
    *Afin* d'être connecté à mon compte

    @ACME @CU00
    Plan du Scénario: S'authentifier avec succès
        Le dashboard doit être présent
        Étant donné Un utilisateur avec le profil "invité"
        Lorsque l'utilisateur s'authentifie avec des identifiants valides
        Alors l'utilisateur doit être connecté

