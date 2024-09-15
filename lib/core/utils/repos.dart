import 'package:dio/dio.dart';
import 'package:koha/features/categories/models/categories.dart';
import 'api.dart';

class KohaRepository {
  final ApiClient _apiClient = ApiClient();

  Future<dynamic> getEditorChoices() async {
    final response = await _apiClient.get('/editor-choices');
    return response.data;
  }

  Future<dynamic> getLatest() async {
    final response = await _apiClient.get('/latest');
    return response.data;
  }

  Future<dynamic> getMostRead() async {
    final response = await _apiClient.get('/most-read');
    return response.data;
  }

  Future<dynamic> getCategoryArticles(String slug, {int? page}) async {
    final response = await _apiClient
        .get('/category/$slug', queryParameters: {'page': page});
    return response.data;
  }

  Future<dynamic> getWeather() async {
    final response = await _apiClient.get('/weather');
    return response.data;
  }

  Future<dynamic> getAqi() async {
    final response = await _apiClient.get('/aqi');
    return response.data;
  }

  Future<dynamic> getIsLive() async {
    final response = await _apiClient.get('/is-live');
    return response.data;
  }

  Future<List<Category>> getCategories() async {
    final response = await _apiClient.get('/categories');
    List<dynamic> data = response.data;
    return data.map((item) => Category.fromJson(item)).toList();
  }

  Future<dynamic> getArticle(String id) async {
    final response = await _apiClient.get('/article/$id');
    return response.data;
  }

  Future<dynamic> getArchive({String? date, String? category}) async {
    String endpoint = '/archive';
    if (date != null) endpoint += '/$date';
    if (category != null) endpoint += '/$category';
    final response = await _apiClient.get(endpoint);
    return response.data;
  }

  Future<dynamic> getHoroscope() async {
    final response = await _apiClient.get('/horoscope');
    return response.data;
  }

  Future<dynamic> postDenonco(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/denonco', data: data);
    return response.data;
  }

  Future<dynamic> search(String keyword) async {
    final response = await _apiClient.get('/search/$keyword');
    return response.data;
  }
}
