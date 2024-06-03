from nltk.corpus import wordnet


def normalize_abbreviations(text: str) -> str:
    resolved_terms = {}
    new_tokens = []

    for token in text.split():
        synsets = wordnet.synsets(token)
        if synsets:
            resolved_term = synsets[0].lemmas()[0].name()
            resolved_terms[token] = resolved_term
            new_tokens.append(resolved_term)
        else:
            new_tokens.append(token)

    return " ".join(new_tokens)

