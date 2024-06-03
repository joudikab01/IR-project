from pymongo import MongoClient


def store_query(dataset, text):
    mongo_client = MongoClient('localhost', 27017)
    db = mongo_client['IR_DOCS']
    collection = db[dataset + '_queries']
    last = collection.find().sort({"index": -1}).limit(1)
    data = {
        '_id': str(int(last[0]['_id']) + 1),
        'index': last[0]['index'] + 1,
        'text': text,
    }
    collection.insert_one(data)
