import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/core/utils/notifiers.dart';
import 'package:koha/core/utils/repos.dart';
import 'package:koha/features/editor_choices/models/editor_choices.dart';

final editorChoicesProvider = StateNotifierProvider<EditorChoicesNotifier,
    AsyncValue<List<EditorChoice>>>((ref) {
  final repository = ref.watch(kohaRepositoryProvider);
  return EditorChoicesNotifier(repository);
});

class EditorChoicesNotifier
    extends StateNotifier<AsyncValue<List<EditorChoice>>> {
  final KohaRepository _repository;

  EditorChoicesNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadEditorChoices();
  }

  Future<void> loadEditorChoices() async {
    state = const AsyncValue.loading();
    try {
      final editorChoicesData = await _repository.getEditorChoices();
      final editorChoices = (editorChoicesData as List)
          .map((item) => EditorChoice.fromJson(item))
          .toList();
      state = AsyncValue.data(editorChoices);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
