from nltk import WordNetLemmatizer, pos_tag
from nltk.corpus import wordnet


def lemmatize_words(text: str) -> str:
    lemmatizer = WordNetLemmatizer()
    tagged_tokens = pos_tag(text.split())
    return " ".join([lemmatizer.lemmatize(word, get_wordnet_pos(pos)) for word, pos in tagged_tokens])


# perform part-of-speech (POS) tagging on the tokens.
def get_wordnet_pos(tag: str) -> str:
    if tag.startswith('J'):
        return wordnet.ADJ
    elif tag.startswith('V'):
        return wordnet.VERB
    elif tag.startswith('N'):
        return wordnet.NOUN
    elif tag.startswith('R'):
        return wordnet.ADV
    else:
        return wordnet.NOUN