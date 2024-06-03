import scispacy
import spacy
from scispacy.abbreviation import AbbreviationDetector


class nlpIn:
    nlp = spacy.load("en_core_sci_md")
    # Add the abbreviation pipe to the spacy pipeline.
    nlp.add_pipe("abbreviation_detector")
    i = 0


def replace_medical_abbreviations_text(tokens):
    new_tokens = []
    for token in tokens:
        doc = nlpIn.nlp(token)
        abbreviation_map = {abbr: abbr._.long_form for abbr in doc._.abbreviations}
        new_to = token
        for abbr, long_form in abbreviation_map.items():
            new_to = token.replace(str(abbr), str(long_form))
        new_tokens.append(new_to)
    return new_tokens
