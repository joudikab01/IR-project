# Evaluate the dataset
import os

import ir_measures
import joblib
from ir_measures import R, AP, P, RR

from .utils.retrieve import retrieve, retrieve_with_clustering
from offline.indexing.utils.tfidf_matrix_operation import load_tfidf_matrix

from utils.constant import QuoraConstant, ClinicalConstant

from ..indexing.utils.kmeans_clusters_operations import load_cluster_labels


def evaluate(dataset_collection, dataset_name):
    qrels = dataset_collection.qrels_iter()
    queries = dataset_collection.queries_iter()
    ranking_docs = dict()
    i = 0
    tfidf_matrix = load_tfidf_matrix(dataset_name)
    for query in queries:
        if dataset_name == QuoraConstant.name:
            retrieved_docs = retrieve(query.text, dataset_name, tfidf_matrix)
        else:
            if query.other == 'None':
                text = query.disease + ' ' + query.gene + ' ' + query.demographic
            else:
                text = query.disease + ' ' + query.gene + ' ' + query.demographic + ' ' + query.other
            print(text)
            retrieved_docs = retrieve(text, dataset_name, tfidf_matrix)
        ranking_docs[query.query_id] = retrieved_docs
        i += 1
        if i % 100 == 0:
            print(i)
    metrics = [AP(rel=1), P(rel=1) @ 10, R(rel=1) @ 10, RR(rel=1)]
    qrels_map = dict()
    for qrel in qrels:
        if qrel.query_id in ranking_docs.keys():
            if qrel.query_id in qrels_map:
                qrels_map[qrel.query_id].update({qrel.doc_id: qrel.relevance})
            else:
                qrels_map[qrel.query_id] = {qrel.doc_id: qrel.relevance}
    score = ir_measures.calc_aggregate(metrics, qrels_map, ranking_docs)
    return score


def evaluate_with_clustering(dataset_collection, dataset_name):
    qrels = dataset_collection.qrels_iter()
    queries = dataset_collection.queries_iter()
    ranking_docs = dict()
    i = 0
    tfidf_matrix = load_tfidf_matrix(dataset_name)
    clustering_labels = load_cluster_labels(dataset_name)
    project_root_dir = os.path.join(
        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))),
        'clustering')
    if dataset_name == QuoraConstant.name:
        cluster_model = joblib.load(project_root_dir + '\\' + QuoraConstant.cluster_path)
    else:
        cluster_model = joblib.load(project_root_dir + '\\' + ClinicalConstant.cluster_path)
    for query in queries:
        if dataset_name == QuoraConstant.name:
            retrieved_docs = retrieve_with_clustering(query.text, dataset_name, tfidf_matrix, cluster_model,
                                                      clustering_labels)
        else:
            if query.other == 'None':
                text = query.disease + ' ' + query.gene + ' ' + query.demographic
            else:
                text = query.disease + ' ' + query.gene + ' ' + query.demographic + ' ' + query.other
            print(text)
            retrieved_docs = retrieve_with_clustering(text, dataset_name, tfidf_matrix, cluster_model,
                                                      clustering_labels)
        ranking_docs[query.query_id] = retrieved_docs
        i += 1
        if i % 100 == 0:
            print(i)
    metrics = [AP(rel=1), P(rel=1) @ 10, R(rel=1) @ 10, RR(rel=1)]
    qrels_map = dict()
    for qrel in qrels:
        if qrel.query_id in ranking_docs.keys():
            if qrel.query_id in qrels_map:
                qrels_map[qrel.query_id].update({qrel.doc_id: qrel.relevance})
            else:
                qrels_map[qrel.query_id] = {qrel.doc_id: qrel.relevance}
    score = ir_measures.calc_aggregate(metrics, qrels_map, ranking_docs)
    return score
