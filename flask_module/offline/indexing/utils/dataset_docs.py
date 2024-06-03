from typing import Dict

import ir_datasets

from db import DataBase


def get_dataset_docs(dataset_name: str) -> Dict[str, str]:
    print("get dataset docs " + dataset_name)
    if dataset_name == "clinical":
        dataset = ir_datasets.load("clinicaltrials/2017/trec-pm-2017")
        docs_iter = dataset.docs_iter()
        random_corpus = {}
        for doc in docs_iter:
            doc_id = doc[0]
            detailed_description = (doc[1] + ' ' + doc[2] + ' ' + doc[3] + ' '
                                    + doc[4] + ' ' + doc[5])
            random_corpus[doc_id] = detailed_description
        random_corpus_ids = set(random_corpus.keys())
        search_qrels = list(ir_datasets.load("clinicaltrials/2017/trec-pm-2017").qrels_iter())
        qrels_docs_ids = set(qrel.doc_id for qrel in search_qrels)
        docs_ids = random_corpus_ids.union(qrels_docs_ids)
        docs_store = ir_datasets.load("clinicaltrials/2017/trec-pm-2017").docs_store()
        mapped_docs = dict(docs_store.get_many(docs_ids))
        corpus = {
            doc_id: doc.title + ' ' + doc.condition + ' ' + doc.summary +
                    ' ' + doc.detailed_description + ' ' + doc.eligibility
            for doc_id, doc in mapped_docs.items()
        }
    else:  # dataset_name == "quora":
        random_corpus = dict(ir_datasets.load("beir/quora/test").docs_iter())
        random_corpus_ids = set(random_corpus.keys())
        qrels = list(ir_datasets.load("beir/quora/test").qrels_iter())
        qrels_docs_ids = set(qrel.doc_id for qrel in qrels)
        docs_ids = random_corpus_ids.union(qrels_docs_ids)
        docs_store = ir_datasets.load("beir/quora/test").docs_store()
        mapped_docs = dict(docs_store.get_many(docs_ids))
        corpus = {}
        for doc_id, doc in mapped_docs.items():
            doc_id = doc[0]
            detailed_description = (doc[1])
            corpus[doc_id] = detailed_description

    print(len(corpus))
    db = DataBase.db
    collection = db[dataset_name]
    collection.drop()
    documents_to_insert = []
    index = 0
    for doc_id, text in corpus.items():
        documents_to_insert.append({'index': index, "_id": doc_id, "text": text})
        index += 1
    collection.insert_many(documents_to_insert)
    return corpus
