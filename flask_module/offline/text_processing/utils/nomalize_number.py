import re

import num2words
import numpy as np


def convert_numbers(text: str) -> str:
    new_text = []
    for w in text.split():
        try:
            w = num2words(int(w))
        except:
            a = 0
        new_text.append(w)
    new_text = np.char.replace(new_text, "-", " ")
    return " ".join(new_text)


def remove_commas_from_numbers(text: str) -> str:
    # Define the regex pattern
    pattern = r'(?<=\d),(?=\d)'
    new_text = []
    # Process each string in the list
    for w in text.split():
        # Replace commas that are between two digits
        w = re.sub(pattern, '', w)
        new_text.append(w)

    return " ".join(new_text)
