import time

from .utils.queries_content import get_full_queries_content, get_ordered_full_queries_content
from .utils.ranking import ranking_queries
from .utils.store import store_query
from .utils.tfidf_matrix_operation import load_tfidf_matrix
from autocorrect import Speller


def get_query_suggestions(query: str, dataset: str) -> dict:
    start_time = time.time()
    tfidf_matrix = load_tfidf_matrix(dataset)
    queries = list(ranking_queries(query, dataset, tfidf_matrix))
    full_queries = get_full_queries_content(queries, dataset)
    ordered_full_queries = get_ordered_full_queries_content(queries, full_queries)
    response = {"data": [doc for doc in ordered_full_queries[:10]]}
    # spell = Speller()
    # response['auto_correct'] = spell(query)
    end_time = time.time()
    response["elapsed_time"] = end_time - start_time
    return response


def add_to_queries(dataset, text):
    spell = Speller()
    text = spell(text)
    store_query(dataset, text)
