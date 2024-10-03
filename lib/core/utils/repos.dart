import 'package:koha/features/articles/models/article.dart';
import 'package:koha/features/articles/models/article_details.dart';
import 'package:koha/features/categories/models/categories.dart';
import 'package:koha/features/categories/models/latest_category_article.dart';
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

  Future<dynamic> getArticle(String id) async {
    final response = await _apiClient.get('/article/$id');
    return response.data;
  }

  Future<ArticleDetails> getArticleDetail(String id) async {
    try {
      final response = await _apiClient.get('/article/$id');
      return ArticleDetails.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, List<LatestCategoryArticle>>>
      getLatestFromCategories() async {
    final categoryIds = [18, 6, 21];
    Map<String, List<LatestCategoryArticle>> result = {};

    for (var id in categoryIds) {
      try {
        final response = await _apiClient.get('/category/$id');
        List<dynamic> data = response.data;
        List<LatestCategoryArticle> articles = data
            .map((item) => LatestCategoryArticle.fromJson(item))
            .take(3)
            .toList();
        result[id.toString()] = articles;
      } catch (e) {
        print('Error fetching articles for category $id: $e');
        result[id.toString()] = [];
      }
    }
    return result;
  }

  Future<dynamic> getVideos(String id) async {
    final response = await _apiClient.get('/video');
    return response.data;
  }

  Future<List<Category>> getCategories() async {
    try {
      final response = await _apiClient.get('/categories');
      List<dynamic> data = response.data;
      return data.map((item) => Category.fromJson(item)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Article>> getCategoryArticles(int categoryId) async {
    try {
      final response = await _apiClient.get('/category/$categoryId');
      List<dynamic> data = response.data;
      return data.map((item) => Article.fromJson(item)).toList();
    } catch (e) {
      rethrow;
    }
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
