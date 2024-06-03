from typing import Dict

from online.matching_ranking.match_ranking import ranking
from online.search.utils.customize_result import customize_result_from_index_to_doc_id

from online.matching_ranking.match_ranking import ranking_with_clustering


def retrieve(query, dataset, tfidf_matrix) -> Dict[str, float]:
    result = ranking(query, dataset, tfidf_matrix)
    return customize_result_from_index_to_doc_id(result, dataset)


def retrieve_with_clustering(query, dataset, tfidf_matrix, kmeans_model, cluster_labels) -> Dict[str, float]:
    result = ranking_with_clustering(query, dataset, tfidf_matrix, kmeans_model, cluster_labels)
    return customize_result_from_index_to_doc_id(result, dataset)
