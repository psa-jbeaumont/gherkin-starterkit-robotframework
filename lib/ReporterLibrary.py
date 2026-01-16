"""
This is the robot listener to store each test status and elapsed time to a NDJSON file named with suitename
"""

import json
import os
import pathlib
from datetime import datetime
from StepsLogger import StepsLogger


class ReporterLibrary(object):
    ROBOT_LISTENER_API_VERSION = 2

    def __init__(self):
        self.ROBOT_LIBRARY_LISTENER = self
        self._logger = StepsLogger(tz="UTC", ms3=True, color=True, emoji=True, colored_console=False)

    @staticmethod
    def extract_suite_and_test(longname: str, sep: str = '.') -> tuple[str, str]:
        """
        Retourne (suite_name, test_name) où test_name est le dernier segment,
        et suite_name est l'avant-dernier (dernier parent). Si longname n'a qu'un
        segment, suite_name est "".
        - Ignore les segments vides (ex: 'A..B' -> ['A','B'])
        - Tolère les espaces accidentels autour du séparateur.
        """
        if longname is None:
            return "", ""
    
        # Nettoyage léger
        s = longname.strip()
    
        # Découper et filtrer les segments vides
        parts = [p.strip() for p in s.split(sep) if p.strip() != ""]
    
        if not parts:
            return "", ""
    
        if len(parts) == 1:
            return "", parts[0]
    
        # Dernier parent + feuille
        return parts[-2], parts[-1]

    @staticmethod
    def get_audit_data(attrs: dict) -> dict:
        """
        Prépare les données d'audit à partir des attributs du test.
        
        Args:
            attrs: attributs du test (longname, status, elapsedtime, message, tags)
        
        Returns:
            dict: données formatées pour l'audit NDJSON
        """
        suite_name, test_name = ReporterLibrary.extract_suite_and_test(attrs['longname'])
        
        data = {
            'timestamp': datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            'source': f"{suite_name.replace(' ', '_').replace('/', '_')}.ndjson",
            'suite_name': suite_name,
            'test_name': test_name,
            'test_status': attrs['status'],
            'test_elapsed': 0 if attrs['status'] == 'FAIL' else attrs['elapsedtime'],
            'test_message': attrs['message'],
            'test_tags': attrs['tags'],
            'jenkins_job_name': os.environ.get('JOB_NAME', 'N/A'),
            'jenkins_build_tag': os.environ.get('BUILD_TAG', 'N/A')
        }
        
        return data
    
    @staticmethod
    def audit_ndjson(audit_trail: dict) -> None:
        """
        Enregistre le résultat d'un test dans un fichier NDJSON.
        Orchestration complète du traitement.
        
        Args:
            audit_trail: données d'audit à écrire dans le fichier NDJSON
        """
        
        # Déterminer le chemin du fichier
        file_path = os.path.join(os.environ.get('WORKSPACE', '.'), audit_trail['source'])
        
        # Écrire les données
        with open(file_path, 'a', encoding='UTF8') as ndjson_file:
            ndjson_file.write(json.dumps(audit_trail) + '\n')

    def _end_test(self, name, attrs):
        """Orchestration pour traiter la fin d'un test."""
        # Obtenir les données d'audit
        audit_trail = ReporterLibrary.get_audit_data(attrs)

        # Auditer le test en NDJSON pour supervision externe
        self.audit_ndjson(audit_trail)

        # Logger Robot pour information interne
        self._logger.test(f"Test '{name}' terminé avec le statut: {audit_trail['test_status']} en {audit_trail['test_elapsed']} ms.") if audit_trail['test_status'] == 'PASS' else \
            self._logger.error(f"Test '{name}' échoué avec le message: {audit_trail['test_message']}", category="TEST")
    
    def _start_test(self, name, attrs):
        """Log le début d'un test."""
        self._logger.test(f"Démarrage du test '{name}'.")

    def _start_keyword(self, name, attrs):
        """Log le début d'un mot-clé."""
        #obtenir le type de bibliotheque socle, step, service, page à partir du suffixe du nom de la bibliothèque
        lib_type = attrs['libname'].split('_')[-1].lower()

        # Construire le message
        msg = f"Démarrage du mot-clé '{attrs['libname']}.{attrs['kwname']}'."

        # Fonction no-op (ne fait rien)
        def _noop(_): 
            return None

        # Dictionnaire de mapping type -> méthode du logger
        switch = {
            "": None,  # Pas de log pour les keywords sans type
            "page":    self._logger.page,
            "service": self._logger.service,
            "socle":   self._logger.socle,
            "step":    self._logger.step
        }

        # Appel via get() avec fallback (par exemple step)
        switch.get(lib_type, _noop)(msg) if attrs['type'] == 'KEYWORD' and attrs['status'] == 'NOT SET' else None
    
    def _end_keyword(self, name, attrs):
        """Log la fin d'un mot-clé."""
        # obtenir le type de bibliothèque depuis le suffixe du nom (ex: Mindefconnect_page -> 'page')
        libname = attrs.get('libname', '')
        lib_type = libname.split('_')[-1].lower() if libname else ''

        status = attrs.get('status', '')

        # types considérés comme pertinents pour un log de succès
        known_types = {"page", "service", "socle", "step"}

        # Si PASS et type connu -> success
        if status == 'PASS' and lib_type in known_types:
            self._logger.success(
                f"Fin du mot-clé '{libname}.{attrs.get('kwname', '')}' avec le statut: {status} en {attrs.get('elapsedtime', 0)} ms.",
                category=lib_type.upper()
            )
            return

        # Si tout autre status différent de PASS -> log d'erreur (quel que soit le type)
        if status == 'FAIL' and lib_type in known_types:
            self._logger.error(
                f"Echec du mot-clé '{libname}.{attrs.get('kwname', '')}'.",
                category=lib_type.upper()
            )
            return

        # Sinon: ne rien logger
        return
