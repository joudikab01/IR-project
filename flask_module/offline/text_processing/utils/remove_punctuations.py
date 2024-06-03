from nltk import RegexpTokenizer


def remove_punctuations(text: str) -> str:
    tokenizer = RegexpTokenizer(r'\w+')
    result = tokenizer.tokenize(text)
    return " ".join(result)
