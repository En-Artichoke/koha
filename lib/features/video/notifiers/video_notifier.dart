import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/core/utils/repos.dart';
import 'package:koha/features/video/models/video.dart';

class VideoNotifier extends StateNotifier<AsyncValue<List<Video>>> {
  final KohaRepository _repository;

  VideoNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadVideos();
  }

  Future<void> loadVideos() async {
    try {
      state = const AsyncValue.loading();
      final dynamic data = await _repository.getVideos('');
      final videos =
          (data as List).map((item) => Video.fromJson(item)).toList();
      state = AsyncValue.data(videos);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final videoProvider =
    StateNotifierProvider<VideoNotifier, AsyncValue<List<Video>>>((ref) {
  final repository = ref.watch(repositoryProvider);
  return VideoNotifier(repository);
});

final repositoryProvider = Provider((ref) => KohaRepository());
