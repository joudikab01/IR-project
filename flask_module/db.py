from pymongo import MongoClient


class DataBase:
    mongo_client = MongoClient('localhost', 27017)
    db = mongo_client['IR_DOCS']