enum SearchType {
  vectorStore,
  wordEmbedding,
  clustering,
  normal;

  @override
  String toString() {
    switch (this) {
      case SearchType.normal:
        return "Normal";
      case SearchType.vectorStore:
        return "Vector Store";
      case SearchType.clustering:
        return "Clustering";
      case SearchType.wordEmbedding:
        return "Word Embedding";
    }
  }

  /// TODO: joudi match it the required values
  String toJson() {
    switch (this) {
      case SearchType.normal:
        return "none";
      case SearchType.vectorStore:
        return "vector_store";
      case SearchType.clustering:
        return "cluster";
      case SearchType.wordEmbedding:
        return "word_embedding";

    }
  }
}
