class QuoraConstant:
    link = 'beir/quora/test'
    name = 'quora'
    cosine_threshold = 0.3
    ngram = (1, 2)
    min_df = 2
    max_df = 0.8
    vectorized_path = 'quora_vectorizer.pkl'
    cluster_path = 'quora_cluster.pkl'
    tfidf_path = ''


class ClinicalConstant:
    link = 'clinicaltrials/2017/trec-pm-2017'
    name = 'clinical'
    cosine_threshold = 0.001
    ngram = (1, 3)
    min_df = 2
    max_df = 0.8
    vectorized_path = 'clinical_vectorizer.pkl'
    cluster_path = 'clinical_cluster.pkl'
    tfidf_path = ''