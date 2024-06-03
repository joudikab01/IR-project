from nltk import word_tokenize
from offline.text_processing.text_processing import process_text_quora, process_text_clinical
from sklearn.metrics.pairwise import cosine_similarity

from .embedding_vector_operation import get_embedding_vector
from .model_operations import load_model
from utils.constant import QuoraConstant, ClinicalConstant


def match_query(dataset, query, matrix, model, docs_id) -> dict:
    if dataset == QuoraConstant.name:
        query = process_text_quora(query)
        similarity_ratio = QuoraConstant.cosine_threshold
    else:
        query = process_text_clinical(query)
        similarity_ratio = ClinicalConstant.cosine_threshold
    query_vector = get_embedding_vector(model, word_tokenize(query))
    matched_documents = {}
    similarity = cosine_similarity(matrix, [query_vector])
    for i, s in enumerate(similarity):
        if s >= similarity_ratio:
            matched_documents[docs_id[i]] = float(s[0])
    return matched_documents
