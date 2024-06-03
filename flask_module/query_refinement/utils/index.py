# Create inverted index with TF-IDF weights
import os

import joblib
from nltk import word_tokenize
from sklearn.feature_extraction.text import TfidfVectorizer

from .queries import get_dataset_queries
from utils.constant import QuoraConstant, ClinicalConstant

from offline.text_processing.text_processing import process_text_quora, process_text_clinical

from .tfidf_matrix_operation import save_tfidf_matrix


def create_inverted_index(dataset: str):
    print("create inverted index queries" + dataset)
    corpus = get_dataset_queries(dataset)
    print("after get_dataset_queries " + dataset)
    if dataset == QuoraConstant.name:
        vectorizer = TfidfVectorizer(preprocessor=process_text_quora, tokenizer=word_tokenize)

    else:
        vectorizer = TfidfVectorizer(preprocessor=process_text_clinical, tokenizer=word_tokenize, norm="l2",
                                     ngram_range=ClinicalConstant.ngram,
                                     sublinear_tf=True,
                                     use_idf=True, )

    print("before fit transform queries" + dataset)
    tfidf_matrix = vectorizer.fit_transform(corpus.values())
    project_root_dir = os.path.join(
        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))),
        'queries_vectorizer')
    if dataset == QuoraConstant.name:
        joblib.dump(vectorizer, project_root_dir + '/' + QuoraConstant.vectorized_path)
    else:
        joblib.dump(vectorizer, project_root_dir + '/' + ClinicalConstant.vectorized_path)
    print("after fit transform queries" + dataset)
    save_tfidf_matrix(dataset, tfidf_matrix)
    return tfidf_matrix
