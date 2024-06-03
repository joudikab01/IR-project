import ir_datasets
from word_embedding.utils.model_operations import load_model
import chromadb

dataset = ir_datasets.load("beir/quora/test")
documents = [doc.text for doc in dataset.docs_iter()]
embedding = load_model('matrix_word_2_vector.pickle')
doc_ids = [doc.doc_id for doc in dataset.docs_iter()]


client = chromadb.PersistentClient()


collection_name = "beir_quora_test"
collection = client.get_or_create_collection(name=collection_name)
batch_size = 1000
x = 0
for i in range(0, len(documents), batch_size):
    x += 1
    print(x)
    batch_docs = documents[i:i + batch_size]
    batch_ids = doc_ids[i:i + batch_size]
    batch_embeddings = [list(float(item2) for item2 in item) for item in embedding[i:i + batch_size]]
    print(len(batch_embeddings))
    collection.add(ids=batch_ids, documents=batch_docs, embeddings=batch_embeddings)
    print(collection.count())

dataset = ir_datasets.load("clinicaltrials/2017/trec-pm-2017")
documents = [doc[1] + ' ' + doc[2] + ' ' + doc[3] + ' ' + doc[4] + ' ' + doc[5] for doc in dataset.docs_iter()]
embedding = load_model('clinical_matrix_word_2_vector.pickle')
doc_ids = [doc[0] for doc in dataset.docs_iter()]
collection_name = "clinical-trials"
collection = client.get_or_create_collection(name=collection_name)
batch_size = 1000
x = 0
for i in range(0, len(documents), batch_size):
    x += 1
    print(x)
    batch_docs = documents[i:i + batch_size]
    batch_ids = doc_ids[i:i + batch_size]
    batch_embeddings = [list(float(item2) for item2 in item) for item in embedding[i:i + batch_size]]
    print(len(batch_embeddings))
    collection.add(ids=batch_ids, documents=batch_docs, embeddings=batch_embeddings)
    print(collection.count())
collection.query()
