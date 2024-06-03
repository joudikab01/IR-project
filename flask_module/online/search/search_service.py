import os
import time

import ir_datasets
import joblib
from autocorrect import Speller
from nltk import word_tokenize

from .utils.documents_content import get_full_documents_content, get_ordered_full_documents_content, \
    get_full_documents_content_with_doc_id, get_ordered_full_documents_content_with_doc_id
from ..matching_ranking.match_ranking import ranking, ranking_with_clustering
from offline.indexing.utils.tfidf_matrix_operation import load_tfidf_matrix

from offline.indexing.utils.kmeans_clusters_operations import load_cluster_labels
from utils.constant import QuoraConstant, ClinicalConstant

from query_refinement.seach_service import add_to_queries

from word_embedding.utils.model_operations import load_model

from word_embedding.utils.match import match_query

from word_embedding.utils.embedding_vector_operation import get_embedding_vector


def get_search_result(query: str, dataset: str) -> dict:
    start_time = time.time()
    tfidf_matrix = load_tfidf_matrix(dataset)
    docs = list(ranking(query, dataset, tfidf_matrix))[:10]
    full_docs = get_full_documents_content(docs, dataset)
    ordered_full_docs = get_ordered_full_documents_content(docs, full_docs)
    add_to_queries(dataset, query)
    spell = Speller()
    response = {"data": [doc for doc in ordered_full_docs], 'auto_correct': spell(query)}
    end_time = time.time()
    response["elapsed_time"] = end_time - start_time
    return response


def get_search_result_with_clustering(query: str, dataset: str) -> dict:
    start_time = time.time()
    tfidf_matrix = load_tfidf_matrix(dataset)
    clustering_labels = load_cluster_labels(dataset)
    project_root_dir = os.path.join(
        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))),
        'clustering')
    if dataset == QuoraConstant.name:
        cluster_model = joblib.load(project_root_dir + '\\' + QuoraConstant.cluster_path)
    else:
        cluster_model = joblib.load(project_root_dir + '\\' + ClinicalConstant.cluster_path)
    docs = list(ranking_with_clustering(query, dataset, tfidf_matrix, cluster_model, clustering_labels))[:10]
    full_docs = get_full_documents_content(docs, dataset)
    ordered_full_docs = get_ordered_full_documents_content(docs, full_docs)
    add_to_queries(dataset, query)
    spell = Speller()
    response = {"data": [doc for doc in ordered_full_docs], 'auto_correct': spell(query)}
    end_time = time.time()
    response["elapsed_time"] = end_time - start_time
    return response


def get_search_result_with_word_embedding(query: str, dataset: str) -> dict:
    start_time = time.time()
    if dataset == QuoraConstant.name:
        model = load_model('quora_word_2_vector.pickle')
        matrix = load_model('matrix_word_2_vector.pickle')
        dataset_collection = ir_datasets.load("beir/quora/test")
    else:
        model = load_model('clinical_word_2_vector.pickle')
        matrix = load_model('clinical_matrix_word_2_vector.pickle')
        dataset_collection = ir_datasets.load("clinicaltrials/2017/trec-pm-2017")
    documents_ids = []
    for d in dataset_collection.docs_iter():
        documents_ids.append(d[0])
    docs = match_query(dataset, query, matrix, model, documents_ids)
    sorted_docs = list(dict(sorted(docs.items(), key=lambda item: item[1], reverse=True)))[:20]
    print(sorted_docs)
    full_docs = get_full_documents_content_with_doc_id(sorted_docs, dataset)
    ordered_full_docs = get_ordered_full_documents_content_with_doc_id(sorted_docs, full_docs)
    add_to_queries(dataset, query)
    spell = Speller()
    response = {"data": [doc for doc in ordered_full_docs], 'auto_correct': spell(query)}
    end_time = time.time()
    response["elapsed_time"] = end_time - start_time
    return response


def search_vector_store(query, dataset_name, client):
    start_time = time.time()
    if dataset_name == 'quora':
        model = load_model('quora_word_2_vector.pickle')
        collection_name = 'beir_quora_test'
    else:
        model = load_model('clinical_word_2_vector.pickle')
        collection_name = 'clinical-trials'
    query_vector = get_embedding_vector(model, word_tokenize(query))
    query_vector_embedded = [list(float(item2) for item2 in query_vector)]
    print("before get_or_create_collection")
    collection = client.get_or_create_collection(name=collection_name)
    print("after get_or_create_collection")
    result = collection.query(query_embeddings=query_vector_embedded, n_results=10)
    print("after query")
    add_to_queries(dataset_name, query)
    print("after add_to_queries")
    spell = Speller()
    data = []
    for doc in result["documents"][0]:
        data.append({"text": doc})
    response = {"data": data,
                'auto_correct': spell(query)}
    end_time = time.time()
    response["elapsed_time"] = end_time - start_time
    return response
