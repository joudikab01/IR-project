import re


def replace_under_score_with_space(text: str) -> str:
    new_tokens = []
    for token in text.split():
        new_tokens.append(re.sub(r'_', ' ', token))
    return " ".join(new_tokens)
