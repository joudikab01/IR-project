from pymongo import MongoClient

from db import DataBase


def customize_result_from_index_to_doc_id(result, dataset: str):
    mongo_client = MongoClient('localhost', 27017)
    db = mongo_client['IR_DOCS']
    collection = db[dataset]
    data = collection.find({"index": {"$in": [int(s) for s in list(result)]}}, {'_id': 1, 'index': 1})
    new_result = {}
    for item in data:
        new_result[item['_id']] = result[str(item['index'])]
    return new_result


def get_results(ordered_full_docs: dict) -> dict:
    total_result = [{'id': doc_id, 'text': doc.text} for doc_id, doc in ordered_full_docs.items()]
    # sliced_result = total_result[:100]
    return {"results": total_result, "result_count": len(total_result)}
