import numpy as np


def get_embedding_vector(model, tokens):
    embeddings = []
    size = model.vector_size
    if len(tokens) < 1:
        return np.zeros(size)
    else:
        for token in tokens:
            if token in model.wv.index_to_key:
                embeddings.append(model.wv.get_vector(token))
            else:
                embeddings.append(np.zeros(size))
    return np.mean(embeddings, axis=0)