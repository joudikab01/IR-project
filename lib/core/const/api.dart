API test = API(baseURL: 'http://192.168.1.2:5000/');

class API {
  final String baseURL;

  API({
    required this.baseURL,
  });

  static const int timeout = 300;

  /// Auth
  static const String searchResults = "get_search_results";
  static const String querySuggestions = "get_query_suggestions";

}
