import gensim
import ir_datasets
from nltk import word_tokenize

from .embedding_vector_operation import get_embedding_vector
from .model_operations import save_model
from offline.text_processing.text_processing import process_text_quora, process_text_clinical

dataset = ir_datasets.load("beir/quora/test")
clinical_dataset = ir_datasets.load("clinicaltrials/2017/trec-pm-2017")


class QuoraMyCorpus:
    documents = []
    documents_ids = []
    i = 0

    def __iter__(self):
        for doc in dataset.docs_iter():
            if QuoraMyCorpus.i >= 522931:
                break
            tokens = process_text_quora(doc[1])
            QuoraMyCorpus.i += 1
            QuoraMyCorpus.documents.append(tokens)
            QuoraMyCorpus.documents_ids.append(doc[0])
            yield tokens


# save word 2 vec model
def word_2_vector_for_quora():
    sentences = QuoraMyCorpus()
    z = [line.split() for line in sentences]
    print("before word 2 vec model")
    model = gensim.models.Word2Vec(sentences=z, min_count=1, workers=4)
    save_model(model, 'quora_word_2_vector.pickle')
    print("after word 2 vec model")
    documents = QuoraMyCorpus.documents
    print("before tokenized_documents & train_matrix")
    train_matrix = [get_embedding_vector(model, word_tokenize(d)) for d in documents]
    save_model(train_matrix, 'matrix_word_2_vector.pickle')
    print("after tokenized_documents & train_matrix")


class ClinicalMyCorpus:
    documents = []
    documents_ids = []
    i = 0

    def __iter__(self):
        for doc in clinical_dataset.docs_iter():
            if ClinicalMyCorpus.i >= 241007:
                break
            tokens = process_text_clinical(doc[1] + ' ' + doc[2] + ' ' + doc[3] + ' ' + doc[4] + ' ' + doc[5])
            ClinicalMyCorpus.i += 1
            ClinicalMyCorpus.documents.append(tokens)
            ClinicalMyCorpus.documents_ids.append(doc[0])
            yield tokens


# save word 2 vec model for clinical
def word_2_vector_for_clinical():
    sentences = ClinicalMyCorpus()
    z = [line.split() for line in sentences]
    print("before word 2 vec model")
    model = gensim.models.Word2Vec(sentences=z, min_count=1, workers=4)
    save_model(model, 'clinical_word_2_vector.pickle')
    print("after word 2 vec model")
    documents = ClinicalMyCorpus.documents
    print("before train_matrix")
    train_matrix = [get_embedding_vector(model, word_tokenize(d)) for d in documents]
    save_model(train_matrix, 'clinical_matrix_word_2_vector.pickle')
    print("after train_matrix")
