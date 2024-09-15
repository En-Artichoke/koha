import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/core/utils/repos.dart';
import 'package:koha/features/articles/models/article.dart';

import '../../../core/utils/notifiers.dart';

class CategoryArticlesNotifier
    extends StateNotifier<AsyncValue<List<Article>>> {
  final KohaRepository _repository;
  int? _lastFetchedCategoryId;

  CategoryArticlesNotifier(this._repository)
      : super(const AsyncValue.loading());

  Future<void> getArticles(int categoryId) async {
    if (_lastFetchedCategoryId == categoryId && state is! AsyncLoading) {
      return;
    }

    state = const AsyncValue.loading();
    try {
      final articles = await _repository.getCategoryArticles(categoryId);
      if (mounted) {
        state = AsyncValue.data(articles);
        _lastFetchedCategoryId = categoryId;
      }
    } catch (e, stack) {
      if (mounted) {
        state = AsyncValue.error(e, stack);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

final categoryArticlesProvider =
    StateNotifierProvider<CategoryArticlesNotifier, AsyncValue<List<Article>>>(
        (ref) {
  final repository = ref.watch(kohaRepositoryProvider);
  return CategoryArticlesNotifier(repository);
});
