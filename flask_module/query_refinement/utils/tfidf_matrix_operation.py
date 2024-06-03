import os
import pickle


def save_tfidf_matrix(dataset_name: str, inverted_index: dict):
    # Move up to the project root directory
    project_root_dir = os.path.join(
        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))),
        'db')
    with open(project_root_dir + '/' + dataset_name + '_queries_inverted_index.pickle', 'wb') as file:
        pickle.dump(inverted_index, file)


def load_tfidf_matrix(dataset_name: str) -> dict:
    project_root_dir = os.path.join(
        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))),
        'db')
    with open(project_root_dir + '/' + dataset_name + '_queries_inverted_index.pickle', 'rb') as file:
        tfidf_matrix = pickle.load(file)
    return tfidf_matrix
