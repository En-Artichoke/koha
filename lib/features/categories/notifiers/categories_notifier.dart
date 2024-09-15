import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/core/utils/notifiers.dart';
import 'package:koha/core/utils/repos.dart';
import 'package:koha/features/categories/models/categories.dart';

class CategoryNotifier extends StateNotifier<AsyncValue<List<Category>>> {
  final KohaRepository _repository;

  CategoryNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> getCategories() async {
    state = const AsyncValue.loading();
    try {
      final categories = await _repository.getCategories();
      state = AsyncValue.data(categories);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, AsyncValue<List<Category>>>((ref) {
  final repository = ref.watch(kohaRepositoryProvider);
  return CategoryNotifier(repository);
});
