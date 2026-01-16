#language: fr
Fonctionnalité:  DS - Accéder à votre dossier
    *En tant que* Usager
    *Je souhaite* accéder à mon dossier
    *Afin* de consulter son résumé

    Contexte: Un usager connecté sur DS
        Étant donné Un utilisateur connecté sur DS avec le profil "usager"
    
    @DS @TNR @CU01
    Plan du Scénario: Accéder au dossier
        Le résumé du dossier doit être présent
        Étant donné Un utilisateur connecté sur DS avec le profil "<profil_utilisateur>"
        Et l'usager recherche les défaillances 
          |Contexte Déclaratif  |Structure Compétente|
          |<contexte_declaratif>|<structure_ifu>   |
        Lorsque l'usager accède à son dossier
        Alors le résumé du dossier doit être présent

    Exemples:
        | profil_utilisateur |contexte_declaratif|structure_ifu   |
        | usager             |france            |CG 13           |

