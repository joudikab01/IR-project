import re


def remove_markers(text: str) -> str:
    normalized_tokens = []
    for token in text.split():
        normalized_tokens.append(re.sub(r'\u00AE', '', token))
    return " ".join(normalized_tokens)