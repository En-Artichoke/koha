import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/core/utils/notifiers.dart';
import 'package:koha/core/utils/repos.dart';
import 'package:koha/features/articles/models/article.dart';

class LatestNewsNotifier
    extends StateNotifier<AsyncValue<Map<String, List<Article>>>> {
  final KohaRepository _repository;

  LatestNewsNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchLatestNews();
  }

  Future<void> fetchLatestNews() async {
    try {
      state = const AsyncValue.loading();
      final latestNewsData = await _repository.getLatest();
      final latestNews = (latestNewsData as List<dynamic>)
          .map((item) => Article.fromJson(item))
          .toList();

      final Map<String, List<Article>> articlesByCategory = {};
      for (var article in latestNews) {
        if (!articlesByCategory.containsKey(article.category.name)) {
          articlesByCategory[article.category.name] = [];
        }
        articlesByCategory[article.category.name]!.add(article);
      }

      state = AsyncValue.data(articlesByCategory);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  List<Article>? getArticlesForCategory(String categoryName) {
    return state.value?[categoryName];
  }
}

final latestNewsProvider = StateNotifierProvider<LatestNewsNotifier,
    AsyncValue<Map<String, List<Article>>>>((ref) {
  final repository = ref.watch(kohaRepositoryProvider);
  return LatestNewsNotifier(repository);
});
