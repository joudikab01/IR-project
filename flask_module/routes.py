import chromadb
from flask import request, jsonify, Flask

from offline.indexing.create_index import create_inverted_index, create_inverted_index_with_clustering
from offline.text_processing.text_processing import process_text_quora, process_text_clinical
from online.search.search_service import get_search_result, get_search_result_with_clustering, \
    get_search_result_with_word_embedding, search_vector_store
from query_refinement.seach_service import get_query_suggestions
from utils.constant import QuoraConstant

# create word embedding (quora, clinical)

# add to vector store (quora, clinical)

app = Flask(__name__)

client = chromadb.PersistentClient()


# process text (quora, clinical)
@app.route('/process_text', methods=['POST'])
def process_text_route():
    data = request.json
    text = data['text']
    dataset = data['dataset']
    if dataset == QuoraConstant.name:
        processed_text = process_text_quora(text)
    else:
        processed_text = process_text_clinical(text)
    return jsonify({'processed_text': processed_text})


# create inverted index (quora, clinical)
@app.route('/create_inverted_index', methods=['POST'])
def create_inverted_index_route():
    data = request.json
    dataset = data['dataset']
    create_inverted_index(dataset)
    return jsonify({'success': "success"})


# create inverted index with clustering (quora, clinical)
@app.route('/create_inverted_index_with_clustering', methods=['POST'])
def create_inverted_index_with_clustering_route():
    data = request.json
    dataset = data['dataset']
    create_inverted_index_with_clustering(dataset)
    return jsonify({'success': "success"})


# get search results with auto-correct and adding the query to the queries collection
# (quora, clinical) without any word embeddings or clustering
@app.route('/get_search_results', methods=['GET'])
def get_search_results_route():
    query = request.args.get('query')
    dataset = request.args.get('dataset')
    search_type = request.args.get('search_type')
    if search_type == 'cluster':
        return get_search_result_with_clustering(query, dataset)
    if search_type == 'word_embedding':
        return get_search_result_with_word_embedding(query, dataset)
    if search_type == 'vector_store':
        print(True)
        return search_vector_store(query, dataset, client)
    return get_search_result(query, dataset)


# get similar queries or query suggestions (quora, clinical)
@app.route('/get_query_suggestions', methods=['GET'])
def get_query_suggestions_route():
    query = request.args.get('query')
    dataset = request.args.get('dataset')
    return get_query_suggestions(query, dataset)


if __name__ == '__main__':
    app.run(debug=True, host='192.168.1.2')
