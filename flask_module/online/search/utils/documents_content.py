from pymongo import MongoClient

from db import DataBase


def get_full_documents_content(docs: list, dataset: str):
    mongo_client = MongoClient('localhost', 27017)
    db = mongo_client['IR_DOCS']
    collection = db[dataset]
    data = collection.find({"index": {"$in": [int(s) for s in docs]}})
    return data


def get_ordered_full_documents_content(docs, full_docs):
    full_docs = full_docs.collection
    data = [full_docs.find_one({"index": int(doc)}) for doc in docs]
    return data


def get_full_documents_content_with_doc_id(docs: list, dataset: str):
    mongo_client = MongoClient('localhost', 27017)
    db = mongo_client['IR_DOCS']
    collection = db[dataset]
    data = collection.find({"_id": {"$in": [s for s in docs]}})
    return data


def get_ordered_full_documents_content_with_doc_id(docs, full_docs):
    full_docs = full_docs.collection
    data = [full_docs.find_one({"_id": doc}) for doc in docs]
    return data