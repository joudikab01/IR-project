import numpy as np
from typing import Dict
from sklearn.metrics.pairwise import cosine_similarity
from utils.constant import QuoraConstant, ClinicalConstant
from .utils.vectorize_query import VectorizeQuery


def ranking(query: str, dataset: str, tfidf_matrix) -> Dict[str, float]:
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


def ranking_with_clustering(query: str, dataset: str, tfidf_matrix, kmeans_model, clustered_labels) -> Dict[str, float]:
    if dataset == QuoraConstant.name:
        cosine_threshold = QuoraConstant.cosine_threshold
    else:
        cosine_threshold = ClinicalConstant.cosine_threshold

    query_vector = VectorizeQuery.get_vectorize(query, dataset)
    target_cluster = kmeans_model.predict(query_vector.reshape(1, -1))[0]

    cluster_indices = np.where(np.array(clustered_labels) == target_cluster)[0]
    cluster_matrix = tfidf_matrix[cluster_indices]

    similarities = cosine_similarity(query_vector.reshape(1, -1), cluster_matrix)

    # First, filter documents using a similarity threshold
    threshold_indices = np.where(similarities >= cosine_threshold)[1]

    # Then, rank the filtered documents based on their similarity scores
    ranked_indices = np.argsort(similarities[0][threshold_indices])[-10:][::-1] 

    results = {}
    for index in ranked_indices:
        doc_id = str(cluster_indices[threshold_indices[index]])
        similarity = similarities[0][threshold_indices[index]]
        results[doc_id] = similarity

    return results
