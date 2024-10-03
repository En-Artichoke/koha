import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/core/utils/repos.dart';
import 'package:koha/features/categories/models/latest_category_article.dart';

import '../../articles/notifiers/article_details_provider.dart';

class LatestCategoryArticlesNotifier extends StateNotifier<
    AsyncValue<Map<String, List<LatestCategoryArticle>>>> {
  final KohaRepository _repository;

  LatestCategoryArticlesNotifier(this._repository)
      : super(const AsyncValue.loading());

  Future<void> getLatestArticles() async {
    state = const AsyncValue.loading();
    try {
      final articles = await _repository.getLatestFromCategories();
      state = AsyncValue.data(articles);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final latestCategoryArticlesProvider = StateNotifierProvider<
    LatestCategoryArticlesNotifier,
    AsyncValue<Map<String, List<LatestCategoryArticle>>>>((ref) {
  final repository = ref.watch(kohaRepositoryProvider);
  return LatestCategoryArticlesNotifier(repository);
});
