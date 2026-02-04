# -*- coding: utf-8 -*-
"""Mini-lib Robot Framework: normalisation & proximité de chaînes.

Objectif
--------
- Normaliser des libellés UI (trim, minuscules, espaces, accents)
- Trouver la chaîne (ou la clé canonique) la plus proche via un score de similarité.

Dépendances: uniquement la bibliothèque standard Python (difflib, unicodedata, re).

Utilisation Robot (exemple)
--------------------------
*** Settings ***
Library    string_matching.py

*** Test Cases ***
Exemple
    @{candidats}=    Create List    publier    en_test    closes    supprimer
    ${best}    ${score}=    Get Closest String    Supprim    ${candidats}    threshold=0.72
    Log    best=${best} score=${score}
"""

from robot.api.deco import library, keyword

import difflib
import re
import unicodedata
from typing import Iterable, List, Mapping, Sequence, Tuple, Union, Any

_Text = Union[str, bytes]


def _to_str(value: Any) -> str:
    if value is None:
        return ""
    if isinstance(value, bytes):
        return value.decode("utf-8", errors="replace")
    return str(value)


def _strip_accents(text: str) -> str:
    # NFD décompose les caractères accentués en (lettre + diacritique)
    # On supprime ensuite les diacritiques (category == 'Mn').
    decomposed = unicodedata.normalize("NFD", text)
    return "".join(ch for ch in decomposed if unicodedata.category(ch) != "Mn")

@library(scope='GLOBAL', version='0.1', doc_format='reST')
class StringMatching:
    """Bibliothèque Robot Framework pour normaliser et comparer des chaînes."""
    ROBOT_LIBRARY_SCOPE = 'SUITE'

    def __init__(self):
        # Cache simple pour accélérer si on normalise souvent les mêmes chaînes.
        self._norm_cache: dict[Tuple[str, bool, bool, bool], str] = {}

    @keyword("Normalize Text For Matching")
    def normalize_text_for_matching(
        self,
        text: _Text,
        *,
        to_lower: bool = True,
        collapse_spaces: bool = True,
        remove_accents: bool = True,
        strip: bool = True,
    ) -> str:
        """Normalise un texte pour faciliter le matching.

        - strip: supprime espaces début/fin
        - to_lower: met en minuscules
        - collapse_spaces: remplace toute séquence d'espaces/tabs/newlines par un seul espace
        - remove_accents: enlève les accents
        """
        s = _to_str(text)
        cache_key = (s, to_lower, collapse_spaces, remove_accents)
        if cache_key in self._norm_cache:
            return self._norm_cache[cache_key]

        if strip:
            s = s.strip()
        if to_lower:
            s = s.lower()
        if collapse_spaces:
            s = re.sub(r"\s+", " ", s)
        if remove_accents:
            s = _strip_accents(s)

        self._norm_cache[cache_key] = s
        return s

    @keyword("Get Closest String")
    def get_closest_string(
        self,
        expected: _Text,
        candidates: Iterable[_Text],
        *,
        threshold: float = 0.72,
        ambiguity_delta: float = 0.05,
        normalize: bool = True,
    ) -> Tuple[str, float]:
        """Retourne (meilleur_candidat, score).

        - threshold: score minimal requis
        - ambiguity_delta: si best - second_best < delta => considéré ambigu
        - normalize: applique la normalisation avant scoring

        Lève ValueError si aucun match fiable ou si ambigu.
        """
        
        if not candidates:
            raise ValueError("Liste de candidats vide")

        exp = _to_str(expected)
        exp_norm = self.normalize_text_for_matching(exp) if normalize else exp

        best_item = ""
        best_score = -1.0
        second_score = -1.0

        for item in candidates:
            print(f"Comparing '{exp}' to candidate '{item}'")
            item_norm = self.normalize_text_for_matching(item) if normalize else item
            score = difflib.SequenceMatcher(None, item_norm, exp_norm).ratio()
            if score > best_score:
                second_score = best_score
                best_score = score
                best_item = item
            elif score > second_score:
                second_score = score

        if best_score < float(threshold):
            raise ValueError(
                f"Aucun match fiable pour '{exp}' : best='{best_item}' score={best_score:.3f} seuil={threshold}"
            )
        if (best_score - second_score) < float(ambiguity_delta):
            raise ValueError(
                f"Match ambigu pour '{exp}' : best='{best_item}' score={best_score:.3f}, second={second_score:.3f}, delta={best_score-second_score:.3f}"
            )

        return best_item

    
