import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/core/utils/repos.dart';
import 'package:koha/features/articles/models/article_details.dart';

class ArticleDetailNotifier extends StateNotifier<AsyncValue<ArticleDetails>> {
  final KohaRepository _repository;
  final String articleId;

  ArticleDetailNotifier(this._repository, this.articleId)
      : super(const AsyncValue.loading()) {
    fetchArticleDetail();
  }

  Future<void> fetchArticleDetail() async {
    try {
      state = const AsyncValue.loading();
      final article = await _repository.getArticleDetail(articleId);
      state = AsyncValue.data(article);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
