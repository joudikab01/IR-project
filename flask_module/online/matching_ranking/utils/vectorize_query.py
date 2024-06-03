import os

import joblib
from utils.constant import QuoraConstant, ClinicalConstant


class VectorizeQuery:
    project_root_dir = os.path.join(
        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))),
        'vectorizer')
    quora_vectorizer = joblib.load( project_root_dir + '\\' + QuoraConstant.vectorized_path)
    clinica_vectorizer = joblib.load(project_root_dir + '\\' + ClinicalConstant.vectorized_path)

    @staticmethod
    def get_vectorize(query, dataset):
        if dataset == QuoraConstant.name:
            query_vector = VectorizeQuery.quora_vectorizer
        else:
            query_vector = VectorizeQuery.clinica_vectorizer
        return query_vector.transform([query])
