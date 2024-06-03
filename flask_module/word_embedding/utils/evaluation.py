import ir_datasets
import ir_measures
from ir_measures import AP, P, R, RR

from .match import match_query
from .model_operations import load_model
from utils.constant import QuoraConstant, ClinicalConstant


def evaluate(dataset_collection, dataset_name):
    qrels = dataset_collection.qrels_iter()
    queries = dataset_collection.queries_iter()
    if dataset_name == QuoraConstant.name:
        model = load_model('quora_word_2_vector.pickle')
        matrix = load_model('matrix_word_2_vector.pickle')
    else:
        model = load_model('clinical_word_2_vector.pickle')
        matrix = load_model('clinical_matrix_word_2_vector.pickle')
    documents_ids = []
    for d in dataset_collection.docs_iter():
        documents_ids.append(d[0])
    print('start evaluation')
    i = 0
    ranking_docs = dict()
    for query in queries:
        i += 1
        print(i)
        if dataset_name == QuoraConstant.name:
            retrieved_docs = match_query(dataset_name, query.text, matrix, model, documents_ids)
        else:
            if query.other == 'None':
                text = query.disease + ' ' + query.gene + ' ' + query.demographic
            else:
                text = query.disease + ' ' + query.gene + ' ' + query.demographic + ' ' + query.other
            retrieved_docs = match_query(dataset_name, text, matrix, model, documents_ids)
        ranking_docs[query.query_id] = retrieved_docs
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