import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/core/utils/notifiers.dart';
import 'package:koha/core/utils/repos.dart';
import 'package:koha/features/most_read/model/most_read_article.dart';

class MostReadNotifier
    extends StateNotifier<AsyncValue<List<MostReadArticle>>> {
  final KohaRepository _repository;

  MostReadNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchMostRead();
  }

  Future<void> fetchMostRead() async {
    try {
      state = const AsyncValue.loading();
      final mostReadData = await _repository.getMostRead();
      final mostRead = (mostReadData as List<dynamic>)
          .map((item) => MostReadArticle.fromJson(item as Map<String, dynamic>))
          .toList();

      state = AsyncValue.data(mostRead);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final mostReadProvider =
    StateNotifierProvider<MostReadNotifier, AsyncValue<List<MostReadArticle>>>(
        (ref) {
  final repository = ref.watch(kohaRepositoryProvider);
  return MostReadNotifier(repository);
});
