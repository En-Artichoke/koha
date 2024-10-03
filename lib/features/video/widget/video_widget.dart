import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:koha/features/video/notifiers/video_notifier.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoListWidget extends ConsumerWidget {
  const VideoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videosAsyncValue = ref.watch(videoProvider);

    return videosAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (videos) => ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          final videoUrl = video.options['video'] as String?;
          final thumbnailUrl = video.thumbnailUrl;

          if (videoUrl == null) {
            return const SizedBox.shrink();
          }

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: VideoPlayerWidget(
              videoUrl: videoUrl,
              thumbnailUrl: thumbnailUrl,
              title: video.title,
            ),
          );
        },
      ),
    );
  }
}

class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;
  final String thumbnailUrl;
  final String title;

  const VideoPlayerWidget({
    Key? key,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.network(
          thumbnailUrl,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey,
              child: const Center(child: Text('No image available')),
            );
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.play_circle_fill,
            size: 50,
            color: Colors.white.withOpacity(0.8),
          ),
          onPressed: () {
            context
                .push('/fullscreen-video?url=${Uri.encodeComponent(videoUrl)}');
          },
        ),
      ],
    );
  }
}

class FullscreenVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const FullscreenVideoPlayer({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  _FullscreenVideoPlayerState createState() => _FullscreenVideoPlayerState();
}

class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    if (videoId == null) {
      setState(() {
        _errorMessage = 'Invalid YouTube URL';
      });
      return;
    }
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        hideControls: false,
        hideThumbnail: true,
      ),
    )..addListener(_listener);
  }

  void _listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            _errorMessage != null
                ? Center(
                    child: Text(_errorMessage!,
                        style: const TextStyle(color: Colors.white)))
                : Center(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.blueAccent,
                        progressColors: const ProgressBarColors(
                          playedColor: Colors.blue,
                          handleColor: Colors.blueAccent,
                        ),
                        onReady: () {
                          _isPlayerReady = true;
                        },
                      ),
                    ),
                  ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
