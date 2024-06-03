import os
import pickle


def save_cluster_labels(dataset_name: str, cluster_labels: dict):
    # Move up to the project root directory
    project_root_dir = os.path.join(
        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))),
        'clustering')
    with open(project_root_dir + '/' + dataset_name + '_cluster_labels.pickle', 'wb') as file:
        pickle.dump(cluster_labels, file)


def load_cluster_labels(dataset_name: str) -> dict:
    project_root_dir = os.path.join(
        os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))),
        'clustering')
    with open(project_root_dir + '/' + dataset_name + '_cluster_labels.pickle', 'rb') as file:
        cluster_labels = pickle.load(file)
    return cluster_labels

