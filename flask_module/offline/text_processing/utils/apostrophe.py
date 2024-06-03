import numpy as np


def remove_apostrophe(text: str) -> str:
    new_tokens = []
    for token in text.split():
        new_tokens.append(str(np.char.replace(token, "'", " ")))
    return " ".join(new_tokens)
