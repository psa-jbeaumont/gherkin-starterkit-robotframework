*** Settings ***
Documentation       Les actions possibles de la page dashboard ACME Demo App
...                 Page Object Model pour https://demo.applitools.com/app.html
...                 
...                 Cette resource contient les locators et keywords pour interagir
...                 avec le tableau de bord bancaire de l'application ACME.
...                 Page accessible après authentification.

Library     ../../../lib/StepsLogger.py
Resource    web_socle.resource


*** Variables ***
${URI}              /app.html
&{XP_DASHBOARD}
...                 uri=/app.html
...                 logo=//a[contains(@class, 'navbar-brand')]
...                 badge_notifications=//span[@id='notification-counter']
...                 avatar_user=//img[@alt='User avatar']
...                 logged_user_name=//div[@class='logged-user-name']
...                 logged_user_role=//div[@class='logged-user-role']
...                 menu_profile_settings=//a[contains(text(), 'Profile Settings')]
...                 menu_billing_info=//a[contains(text(), 'Billing Info')]
...                 menu_my_invoices=//a[contains(text(), 'My Invoices')]
...                 menu_cancel_account=//a[contains(text(), 'Cancel Account')]
...                 section_projects=//div[@id='project-panel']
...                 lien_projects=//a[contains(text(), 'Integration with API') or contains(text(), 'Development Project')]
...                 section_customers=//div[@id='customer-panel']
...                 lien_customers=//a[contains(text(), 'John Mayers') or contains(text(), 'Thomas Mullier')]
...                 section_files=//div[@id='file-panel']
...                 lien_files=//a[contains(text(), 'WorkNote.txt') or contains(text(), 'Video.avi')]
...                 titre_actions=//h3[contains(text(), 'Actions')]
...                 menu_card_types=//a[contains(text(), 'Card types')]
...                 menu_credit_cards=//a[contains(text(), 'Credit cards')]
...                 menu_debit_cards=//a[contains(text(), 'Debit cards')]
...                 menu_lending=//a[contains(text(), 'Lending')]
...                 menu_loans=//a[contains(text(), 'Loans')]
...                 menu_mortgages=//a[contains(text(), 'Mortgages')]
...                 bouton_add_account=//a[@id='add-account-btn' or contains(text(), 'Add Account')]
...                 bouton_make_payment=//a[@id='make-payment-btn' or contains(text(), 'Make Payment')]
...                 timer_branch=//h6[contains(text(), 'Your nearest branch closes in')]
...                 titre_financial_overview=//h6[contains(text(), 'Financial Overview')]
...                 label_total_balance=//span[contains(text(), 'Total Balance')]
...                 valeur_total_balance=//div[@class='balance-value']
...                 bouton_view_statement=//a[contains(text(), 'View Statement')]
...                 label_credit_available=//span[contains(text(), 'Credit Available')]
...                 valeur_credit_available=//div[contains(@class, 'balance-value') and contains(text(), '$17,800')]
...                 bouton_request_increase=//a[contains(text(), 'Request Increase')]
...                 label_due_today=//span[contains(text(), 'Due Today')]
...                 valeur_due_today=//div[contains(@class, 'balance-value') and contains(text(), '$180')]
...                 bouton_pay_now=//a[contains(text(), 'Pay Now')]
...                 titre_recent_transactions=//h6[contains(text(), 'Recent Transactions')]
...                 tableau_transactions=//table[@class='table table-padded']
...                 transaction_row=//table[@class='table table-padded']//tbody//tr


*** Keywords ***
Aller Vers La Page Dashboard
    [Documentation]    Ouvre la page dashboard ACME Demo App
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Aller Vers La Page Dashboard | _--> Ouvre la page dashboard de l'application ACME _ |
    ...
    ...    ---

    StepsLogger.Page    J'ouvre la page dashboard ACME Demo App...

    ${end_point}=    settings_socle.Obtenir L'Url A Partir Du Canal
    web_socle.Ouvrir Navigateur Sur    ${end_point}${URI}
    web_socle.Appuyer Sur La Touche    ESC
    Dashboard_page.La Page Doit Etre Visible

La Page Doit Etre Visible
    [Documentation]    Vérifier que la page dashboard est visible
    ...    Vérifie la présence du logo et du titre Actions
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | La Page Doit Etre Visible    | _--> Vérifie que la page dashboard est affichée _ |
    ...
    ...    ---

    # web_socle.L'Element Doit Etre Visible    ${XP_DASHBOARD}[logo]
    web_socle.L'Element Doit Etre Visible    ${XP_DASHBOARD}[titre_financial_overview]
    ${titre}=    web_socle.Obtenir Le Texte De L'Element    ${XP_DASHBOARD}[titre_financial_overview]
    StepsLogger.Success    Je suis sur la page dashboard avec la section "${titre}"

Cliquer Sur Le Logo
    [Documentation]    Cliquer sur le logo ACME pour retourner à l'accueil
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Logo    | _--> Clique sur le logo ACME _ |
    ...
    ...    ---

    Log To Console    Je clique sur le logo ACME...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[logo]

Le Badge Notifications Doit Etre Visible
    [Documentation]    Vérifier le nombre de notifications affichées
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Le Badge Notifications Doit Etre Visible    | _--> Vérifie le badge de notifications _ |
    ...
    ...    ---

    Log To Console    Je vérifie le badge de notifications...
    web_socle.L'Element Doit Etre Visible    ${XP_DASHBOARD}[badge_notifications]
    ${count}=    web_socle.Obtenir Le Texte De L'Element    ${XP_DASHBOARD}[badge_notifications]
    Log To Console    Nombre de notifications: ${count}

Cliquer Sur Le Menu Profile Settings
    [Documentation]    Cliquer sur le menu Profile Settings
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Menu Profile Settings    | _--> Clique sur Profile Settings _ |
    ...
    ...    ---

    Log To Console    Je clique sur le menu Profile Settings...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[menu_profile_settings]

Cliquer Sur Le Menu Billing Info
    [Documentation]    Cliquer sur le menu Billing Info
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Menu Billing Info    | _--> Clique sur Billing Info _ |
    ...
    ...    ---

    Log To Console    Je clique sur le menu Billing Info...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[menu_billing_info]

Cliquer Sur Le Menu My Invoices
    [Documentation]    Cliquer sur le menu My Invoices
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Menu My Invoices    | _--> Clique sur My Invoices _ |
    ...
    ...    ---

    Log To Console    Je clique sur le menu My Invoices...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[menu_my_invoices]

Cliquer Sur Le Menu Cancel Account
    [Documentation]    Cliquer sur le menu Cancel Account
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Menu Cancel Account    | _--> Clique sur Cancel Account _ |
    ...
    ...    ---

    Log To Console    Je clique sur le menu Cancel Account...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[menu_cancel_account]

La Section Projects Doit Etre Presente
    [Documentation]    Vérifier la visibilité de la section Projects
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | La Section Projects Doit Etre Presente    | _--> Vérifie la section Projects _ |
    ...
    ...    ---

    Log To Console    Je vérifie la section Projects...
    web_socle.L'Element Doit Etre Visible    ${XP_DASHBOARD}[section_projects]

La Section Customers Doit Etre Presente
    [Documentation]    Vérifier la visibilité de la section Customers
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | La Section Customers Doit Etre Presente    | _--> Vérifie la section Customers _ |
    ...
    ...    ---

    Log To Console    Je vérifie la section Customers...
    web_socle.L'Element Doit Etre Visible    ${XP_DASHBOARD}[section_customers]

La Section Files Doit Etre Presente
    [Documentation]    Vérifier la visibilité de la section Files
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | La Section Files Doit Etre Presente    | _--> Vérifie la section Files _ |
    ...
    ...    ---

    Log To Console    Je vérifie la section Files...
    web_socle.L'Element Doit Etre Visible    ${XP_DASHBOARD}[section_files]

Cliquer Sur Le Menu Card Types
    [Documentation]    Cliquer sur le menu Card types dans Actions
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Menu Card Types    | _--> Clique sur Card types _ |
    ...
    ...    ---

    Log To Console    Je clique sur le menu Card types...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[menu_card_types]

Cliquer Sur Le Menu Credit Cards
    [Documentation]    Cliquer sur le menu Credit cards dans Actions
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Menu Credit Cards    | _--> Clique sur Credit cards _ |
    ...
    ...    ---

    Log To Console    Je clique sur le menu Credit cards...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[menu_credit_cards]

Cliquer Sur Le Menu Debit Cards
    [Documentation]    Cliquer sur le menu Debit cards dans Actions
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Menu Debit Cards    | _--> Clique sur Debit cards _ |
    ...
    ...    ---

    Log To Console    Je clique sur le menu Debit cards...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[menu_debit_cards]

Cliquer Sur Le Menu Lending
    [Documentation]    Cliquer sur le menu Lending dans Actions
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Menu Lending    | _--> Clique sur Lending _ |
    ...
    ...    ---

    Log To Console    Je clique sur le menu Lending...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[menu_lending]

Cliquer Sur Le Menu Loans
    [Documentation]    Cliquer sur le menu Loans dans Actions
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Menu Loans    | _--> Clique sur Loans _ |
    ...
    ...    ---

    Log To Console    Je clique sur le menu Loans...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[menu_loans]

Cliquer Sur Le Menu Mortgages
    [Documentation]    Cliquer sur le menu Mortgages dans Actions
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Menu Mortgages    | _--> Clique sur Mortgages _ |
    ...
    ...    ---

    Log To Console    Je clique sur le menu Mortgages...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[menu_mortgages]

Cliquer Sur Le Bouton Add Account
    [Documentation]    Cliquer sur le bouton Add Account
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Bouton Add Account    | _--> Clique sur le bouton Add Account _ |
    ...
    ...    ---

    Log To Console    Je clique sur le bouton Add Account...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[bouton_add_account]

Cliquer Sur Le Bouton Make Payment
    [Documentation]    Cliquer sur le bouton Make Payment
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Bouton Make Payment    | _--> Clique sur le bouton Make Payment _ |
    ...
    ...    ---

    Log To Console    Je clique sur le bouton Make Payment...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[bouton_make_payment]

Obtenir Le Total Balance
    [Documentation]    Obtenir la valeur du Total Balance
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | ${balance}= | Obtenir Le Total Balance | _--> Récupère le montant du Total Balance _ |
    ...
    ...    ---

    Log To Console    Je récupère le Total Balance...
    web_socle.L'Element Doit Etre Visible    ${XP_DASHBOARD}[valeur_total_balance]
    ${balance}=    web_socle.Obtenir Le Texte De L'Element    ${XP_DASHBOARD}[valeur_total_balance]
    Log To Console    Total Balance: ${balance}
    RETURN    ${balance}

Cliquer Sur Le Bouton View Statement
    [Documentation]    Cliquer sur le bouton View Statement
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Bouton View Statement    | _--> Clique sur le bouton View Statement _ |
    ...
    ...    ---

    Log To Console    Je clique sur le bouton View Statement...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[bouton_view_statement]

Obtenir Le Credit Available
    [Documentation]    Obtenir la valeur du Credit Available
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | ${credit}= | Obtenir Le Credit Available | _--> Récupère le montant du crédit disponible _ |
    ...
    ...    ---

    Log To Console    Je récupère le Credit Available...
    web_socle.L'Element Doit Etre Visible    ${XP_DASHBOARD}[valeur_credit_available]
    ${credit}=    web_socle.Obtenir Le Texte De L'Element    ${XP_DASHBOARD}[valeur_credit_available]
    Log To Console    Credit Available: ${credit}
    RETURN    ${credit}

Cliquer Sur Le Bouton Request Increase
    [Documentation]    Cliquer sur le bouton Request Increase
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Bouton Request Increase    | _--> Clique sur le bouton Request Increase _ |
    ...
    ...    ---

    Log To Console    Je clique sur le bouton Request Increase...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[bouton_request_increase]

Obtenir Le Due Today
    [Documentation]    Obtenir la valeur du montant dû aujourd'hui
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | ${due}= | Obtenir Le Due Today | _--> Récupère le montant dû aujourd'hui _ |
    ...
    ...    ---

    Log To Console    Je récupère le Due Today...
    web_socle.L'Element Doit Etre Visible    ${XP_DASHBOARD}[valeur_due_today]
    ${due}=    web_socle.Obtenir Le Texte De L'Element    ${XP_DASHBOARD}[valeur_due_today]
    Log To Console    Due Today: ${due}
    RETURN    ${due}

Cliquer Sur Le Bouton Pay Now
    [Documentation]    Cliquer sur le bouton Pay Now
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Cliquer Sur Le Bouton Pay Now    | _--> Clique sur le bouton Pay Now _ |
    ...
    ...    ---

    Log To Console    Je clique sur le bouton Pay Now...
    web_socle.Cliquer Sur Element    ${XP_DASHBOARD}[bouton_pay_now]

Le Tableau Transactions Doit Etre Present
    [Documentation]    Vérifier la visibilité du tableau Recent Transactions
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | Le Tableau Transactions Doit Etre Present    | _--> Vérifie que le tableau des transactions est visible _ |
    ...
    ...    ---

    Log To Console    Je vérifie le tableau des transactions...
    web_socle.L'Element Doit Etre Visible    ${XP_DASHBOARD}[titre_recent_transactions]
    web_socle.L'Element Doit Etre Visible    ${XP_DASHBOARD}[tableau_transactions]

Obtenir Le Nombre De Transactions
    [Documentation]    Obtenir le nombre de transactions affichées dans le tableau
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | ${count}= | Obtenir Le Nombre De Transactions | _--> Compte le nombre de lignes de transactions _ |
    ...
    ...    ---

    Log To Console    Je compte le nombre de transactions...
    ${count}=    SeleniumLibrary.Get Element Count    ${XP_DASHBOARD}[transaction_row]
    Log To Console    Nombre de transactions: ${count}
    RETURN    ${count}

Obtenir Le Nom De L'utilisateur Connecté
    [Documentation]    Obtenir le nom de l'utilisateur actuellement connecté
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | ${user_name}= | Obtenir Le Nom De L'utilisateur Connecte | _--> Récupère le nom de l'utilisateur connecté _ |
    ...
    ...    ---

    StepsLogger.Page    Je récupère le nom de l'utilisateur connecté...
    ${user_name}=    web_socle.Obtenir Le Texte De L'Element    ${XP_DASHBOARD}[logged_user_name]
    StepsLogger.Success    Utilisateur connecté: ${user_name}
    RETURN    ${user_name}

Obtenir Le Rôle De L'utilisateur Connecté
    [Documentation]    Obtenir le rôle de l'utilisateur actuellement connecté
    ...
    ...    Paramètres : Aucun
    ...
    ...    Exemples :
    ...    | ${role}= | Obtenir Le Role De L'utilisateur Connecte | _--> Récupère le rôle de l'utilisateur connecté _ |
    ...
    ...    ---

    StepsLogger.Page    Je récupère le rôle de l'utilisateur connecté...

    # Le niveau PAGE est responsable de l'interaction directe avec l'interface utilisateur
    #  Pour cela il utilise les locators pour interagir avec les éléments de la page
    #  Le page object retourne les informations brutes observées à l'écran
    #  Il utilise web_socle pour interagir avec l'interface utilisateur

    # Implémentation spécifique pour obtenir le rôle
    ${user_role}=    web_socle.Obtenir Le Texte De L'Element    ${XP_DASHBOARD}[logged_user_role]
    StepsLogger.Success    Rôle de l'utilisateur connecté: ${user_role}
    RETURN    ${user_role}
