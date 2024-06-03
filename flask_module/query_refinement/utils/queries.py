from typing import Dict

import ir_datasets
from pymongo import MongoClient


def get_dataset_queries(dataset_name: str) -> Dict[str, str]:
    print("get dataset queries " + dataset_name)
    if dataset_name == "clinical":
        dataset = ir_datasets.load("clinicaltrials/2017/trec-pm-2017")
        queries_iter = dataset.queries_iter()
        corpus = {}
        for doc in queries_iter:
            doc_id = doc[0]
            text = (doc[1] + ' ' + doc[2] + ' ' + doc[3] + ' ' + doc[4])
            corpus[doc_id] = text

    else:  # dataset_name == "quora":
        queries_iter = dict(ir_datasets.load("beir/quora/test").queries_iter())
        corpus = {}
        for doc_id, doc in queries_iter.items():
            corpus[doc_id] = doc

    print(len(corpus))
    mongo_client = MongoClient('localhost', 27017)
    db = mongo_client['IR_DOCS']
    collection = db[dataset_name+'_queries']
    collection.drop()
    documents_to_insert = []
    index = 0
    for doc_id, text in corpus.items():
        documents_to_insert.append({'index': index, "_id": doc_id, "text": text})
        index += 1
    collection.insert_many(documents_to_insert)
    return corpus
