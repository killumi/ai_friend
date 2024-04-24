import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/firebase/fire_storage.dart';
import 'package:ai_friend/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoMessageWidget extends StatefulWidget {
  final IChatMessage message;

  const VideoMessageWidget({required this.message, super.key});

  @override
  State<VideoMessageWidget> createState() => _VideoMessageWidgetState();
}

class _VideoMessageWidgetState extends State<VideoMessageWidget>
    with AutomaticKeepAliveClientMixin {
  VideoPlayerController? _controller;
  bool _isPlaying = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initVideoController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initVideoController() async {
    final url =
        await locator<FireStorageProvider>().getMediaUrl(widget.message);
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));

    await _controller!.initialize().then((_) {
      _controller!.addListener(() {
        if (!_controller!.value.isPlaying) {
          if (mounted) {
            setState(() {
              _isPlaying = false;
            });
          }
        }
      });
    });
  }

  void _toggleVideoPlayback() {
    setState(() {
      _isPlaying = !_isPlaying;

      if (_isPlaying) {
        _controller!.play();
      } else {
        _controller!.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: _toggleVideoPlayback,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.greenAccent,
        ),
        height: 380,
        child: _controller?.value.isInitialized ?? false
            ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                // aspectRatio: 9 / 16,
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: VideoPlayer(_controller!)),
                    if (!_controller!.value.isPlaying)
                      const Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                  ],
                ),
              )
            : const AspectRatio(
                aspectRatio: 9 / 16,
                child: Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.black,
                    radius: 18,
                  ),
                ),
              ),
      ),
    );
  }
}
