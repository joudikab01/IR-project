import os
import pickle


def save_model(obj, file_name: str):
    project_root_dir = os.path.join(
        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))),
        'word_embedding_model')
    with open(project_root_dir + '/' + file_name, 'wb') as file:
        pickle.dump(obj, file)


def load_model(file_name) -> dict:
    project_root_dir = os.path.join(
        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))),
        'word_embedding_model')
    with open(project_root_dir + '/' + file_name, 'rb') as file:
        model = pickle.load(file)
    return model

