# Create inverted index with TF-IDF weights
import os

import joblib
from nltk import word_tokenize
from sklearn.cluster import KMeans
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.preprocessing import normalize

from .utils.kmeans_clusters_operations import save_cluster_labels
from .utils.tfidf_matrix_operation import save_tfidf_matrix, load_tfidf_matrix
from ..text_processing.text_processing import process_text_quora, process_text_clinical
from .utils.dataset_docs import get_dataset_docs
from utils.constant import QuoraConstant, ClinicalConstant


def create_inverted_index(dataset: str):
    print("create inverted index " + dataset)
    corpus = get_dataset_docs(dataset)
    print("after get_dataset_docs " + dataset)
    if dataset == QuoraConstant.name:
        vectorizer = TfidfVectorizer(preprocessor=process_text_quora, tokenizer=word_tokenize,
                                     # max_df=QuoraConstant.max_df,
                                     # min_df=QuoraConstant.min_df,
                                     # norm="l2",
                                     # ngram_range=QuoraConstant.ngram,
                                     # sublinear_tf=True,
                                     # use_idf=True,
                                     # use_idf=True,

                                     )

    else:
        vectorizer = TfidfVectorizer(preprocessor=process_text_clinical, tokenizer=word_tokenize,
                                     # max_df=ClinicalConstant.max_df,
                                     # min_df=ClinicalConstant.min_df,
                                     norm="l2",
                                     # ngram_range=ClinicalConstant.ngram,
                                     sublinear_tf=True,
                                     use_idf=True,
                                     stop_words='english',
                                     lowercase=False,
                                     )

    print("before fit transform " + dataset)
    tfidf_matrix = vectorizer.fit_transform(corpus.values())
    project_root_dir = os.path.join(
        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))),
        'vectorizer')
    if dataset == QuoraConstant.name:
        joblib.dump(vectorizer, project_root_dir + '/' + QuoraConstant.vectorized_path)
    else:
        joblib.dump(vectorizer, project_root_dir + '/' + ClinicalConstant.vectorized_path)
    print("after fit transform " + dataset)
    save_tfidf_matrix(dataset, tfidf_matrix)
    # save_doc_ids(dataset, corpus.keys())
    return tfidf_matrix


def create_inverted_index_with_clustering(dataset: str):
    print("create inverted index with clustering " + dataset)
    corpus = get_dataset_docs(dataset)
    print("after get_dataset_docs with clustering" + dataset)
    if dataset == QuoraConstant.name:
        vectorizer = TfidfVectorizer(preprocessor=process_text_quora, tokenizer=word_tokenize,)

    else:
        vectorizer = TfidfVectorizer(preprocessor=process_text_clinical, tokenizer=word_tokenize,
                                     norm="l2",
                                     sublinear_tf=True,
                                     use_idf=True,
                                     stop_words='english',
                                     lowercase=False,
                                     )

    print("before fit transform " + dataset)
    tfidf_matrix = vectorizer.fit_transform(corpus.values())
    project_root_dir = os.path.join(
        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))),
        'vectorizer')
    if dataset == QuoraConstant.name:
        joblib.dump(vectorizer, project_root_dir + '/' + QuoraConstant.vectorized_path)
    else:
        joblib.dump(vectorizer, project_root_dir + '/' + ClinicalConstant.vectorized_path)
    print("after fit transform " + dataset)
    save_tfidf_matrix(dataset, tfidf_matrix)
    kmeans = KMeans(n_clusters=3, random_state=2)
    cluster_labels = kmeans.fit_predict(tfidf_matrix)
    project_root_dir = os.path.join(
        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))),
        'clustering')
    if dataset == QuoraConstant.name:
        joblib.dump(kmeans, project_root_dir + '/' + QuoraConstant.cluster_path)
    else:
        joblib.dump(kmeans, project_root_dir + '/' + ClinicalConstant.cluster_path)
    print("after kmeans fit " + dataset)
    save_cluster_labels(dataset, cluster_labels)
    return tfidf_matrix

