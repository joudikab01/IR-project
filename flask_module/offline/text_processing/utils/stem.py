from nltk import PorterStemmer


def stem_words(text: str) -> str:
    porter = PorterStemmer()
    return " ".join([porter.stem(word) for word in text.split()])
