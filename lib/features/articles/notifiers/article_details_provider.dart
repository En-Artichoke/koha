import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/core/utils/repos.dart';
import 'package:koha/features/articles/models/article_details.dart';
import 'package:koha/features/articles/notifiers/article_details_notifier.dart';

final kohaRepositoryProvider = Provider<KohaRepository>((ref) {
  return KohaRepository();
});

final articleDetailNotifierProvider = StateNotifierProvider.family<
    ArticleDetailNotifier, AsyncValue<ArticleDetails>, String>(
  (ref, articleId) {
    final repository = ref.watch(kohaRepositoryProvider);
    return ArticleDetailNotifier(repository, articleId);
  },
);
