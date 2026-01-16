"""
Librairie Robot Framework pour convertir les tables Gherkin en dictionnaires Python.

Cette libraire fournit des keywords pour transformer les données tabulaires
du parser Gherkin en structures de données Python (dict, list).
"""


class GherkinDatatableConverter:
    """Convertisseur de tables Gherkin en dictionnaires Python.
    
    Fournit des keywords pour convertir les tables au format Gherkin
    (issues du parser Robot Framework) en dictionnaires ou listes de dictionnaires.
    """

    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    ROBOT_LIBRARY_VERSION = '1.0'

    def convert_datatable_to_dict(self, table_data):
        """Convertit une table Gherkin en dictionnaire clé-valeur.
        
        La première ligne est considérée comme les en-têtes,
        la deuxième ligne contient les valeurs.
        
        Args:
            table_data: Liste de dictionnaires contenant les cellules au format Gherkin
            
        Returns:
            Dictionnaire avec en-têtes comme clés et valeurs de la deuxième ligne
            
        Examples:
        | ${result}= | Convert Datatable To Dict | ${table_data} |
        | Log | ${result} |
        """
        if not table_data or len(table_data) < 2:
            return {}
        
        # Extraire les en-têtes (première ligne)
        headers = [cell['value'] for cell in table_data[0]['cells']]
        
        # Extraire les valeurs (deuxième ligne)
        values = [cell['value'] for cell in table_data[1]['cells']]
        
        # Créer le dictionnaire
        return dict(zip(headers, values))

    def convert_datatable_to_list_of_dicts(self, table_data):
        """Convertit une table Gherkin en liste de dictionnaires.
        
        La première ligne est considérée comme les en-têtes,
        chaque ligne suivante devient un dictionnaire.
        
        Args:
            table_data: Liste de dictionnaires contenant les cellules au format Gherkin
            
        Returns:
            Liste de dictionnaires, une pour chaque ligne de données
            
        Examples:
        | ${result}= | Convert Datatable To List Of Dicts | ${table_data} |
        | Log Many | @{result} |
        """
        if not table_data or len(table_data) < 2:
            return []
        
        # Extraire les en-têtes
        headers = [cell['value'] for cell in table_data[0]['cells']]
        
        # Créer une liste de dictionnaires pour chaque ligne
        result = []
        for row in table_data[1:]:
            values = [cell['value'] for cell in row['cells']]
            result.append(dict(zip(headers, values)))
        
        return result
