from typing import Dict

from sklearn.metrics.pairwise import cosine_similarity

from utils.constant import QuoraConstant, ClinicalConstant
from .vectorize_query import VectorizeQuery


def ranking_queries(query: str, dataset: str, tfidf_matrix) -> Dict[str, float]:
    if dataset == QuoraConstant.name:
        cosine_threshold = QuoraConstant.cosine_threshold
    else:
        cosine_threshold = ClinicalConstant.cosine_threshold
    query_vector = VectorizeQuery.get_vectorize(query, dataset)
    similarities = cosine_similarity(query_vector, tfidf_matrix)
    matched_indices = similarities.argsort()[0][::-1].flatten()
    top_indices = []
    for i in matched_indices:
        if similarities[0][i] >= cosine_threshold:
            top_indices.append(i.item())
    results = {}
    for index in top_indices:
        doc_id = str(index)
        similarity = similarities[0][index]
        results[doc_id] = similarity
    return results
