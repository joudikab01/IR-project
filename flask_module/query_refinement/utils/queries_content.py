from pymongo import MongoClient


def get_full_queries_content(queries: list, dataset: str):
    mongo_client = MongoClient('localhost', 27017)
    db = mongo_client['IR_DOCS']
    collection = db[dataset + '_queries']
    data = collection.find({"index": {"$in": [int(s) for s in queries]}})
    return data


def get_ordered_full_queries_content(queries, full_docs):
    full_docs = full_docs.collection
    data = [full_docs.find_one({"index": int(doc)})['text'] for doc in queries]
    return data
