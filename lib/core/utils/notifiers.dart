import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/core/utils/repos.dart';

final kohaRepositoryProvider = Provider((ref) => KohaRepository());

class KohaNotifier extends StateNotifier<AsyncValue<dynamic>> {
  final KohaRepository _repository;

  KohaNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> getEditorChoices() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getEditorChoices();
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> getLatest() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getLatest();
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> getMostRead() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getMostRead();
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> getCategoryArticles(String slug, {int? page}) async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getCategoryArticles(slug, page: page);
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> getWeatherAndAqi() async {
    state = const AsyncValue.loading();
    try {
      final weatherData = await _repository.getWeather();
      final aqiData = await _repository.getAqi();
      state = AsyncValue.data({
        'weather': weatherData,
        'aqi': aqiData,
      });
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> getAqi() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getAqi();
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> getIsLive() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getIsLive();
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> getCategories() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getCategories();
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> getArticle(String id) async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getArticle(id);
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> getArchive({String? date, String? category}) async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getArchive(date: date, category: category);
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> getHoroscope() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.getHoroscope();
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> postDenonco(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.postDenonco(data);
      state = AsyncValue.data(result);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> search(String keyword) async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.search(keyword);
      state = AsyncValue.data(data);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final kohaNotifierProvider =
    StateNotifierProvider<KohaNotifier, AsyncValue<dynamic>>((ref) {
  final repository = ref.watch(kohaRepositoryProvider);
  return KohaNotifier(repository);
});
