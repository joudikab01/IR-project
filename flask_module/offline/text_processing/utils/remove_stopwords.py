from nltk.corpus import stopwords


def remove_stopwords(text: str, dataset: str) -> str:
    stop_words = set(stopwords.words('english'))
    questions = {'what', 'which', 'who', 'where', 'why', 'when', 'how', 'whose', 'how often', 'how long', 'how far',
                 'how old', 'how come', 'how much', 'how many', 'what type', 'what kind', 'which type', 'which kind'}
    if dataset == 'quora':
        stop_words = stop_words - questions
    else:
        stop_words = stop_words - {'a'}
    return " ".join([word for word in str(text).split() if word not in stop_words])