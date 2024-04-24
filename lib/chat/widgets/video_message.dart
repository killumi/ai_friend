import 'package:ai_friend/chat/chat_storage.dart';
import 'package:ai_friend/chat/widgets/image_message.dart';
import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/firebase/fire_storage.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import 'package:video_player/video_player.dart';

class VideoMessage extends StatefulWidget {
  final IChatMessage message;
  final bool? isPreview;

  const VideoMessage({required this.message, this.isPreview = true, super.key});

  @override
  State<VideoMessage> createState() => _VideoMessageState();
}

class _VideoMessageState extends State<VideoMessage>
    with AutomaticKeepAliveClientMixin {
  VideoPlayerController? _controller;
  bool _isPlaying = true;
  final firebaseProvider = locator<FireStorageProvider>();

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
    if (widget.message.mediaData != null) {
      final file = await firebaseProvider.getMediaFile(
          widget.message.mediaData!, widget.message.content, 'mp4');
      _controller = VideoPlayerController.file(file);
      _controller!.setVolume(0);
    } else {
      final url = await firebaseProvider.getMediaUrl(widget.message);
      _controller = VideoPlayerController.networkUrl(Uri.parse(url));
      _controller!.setVolume(0);
    }

    await _controller!.initialize().then((_) async {
      _controller!.addListener(() {
        if (!_controller!.value.isPlaying) {
          if (mounted) {
            setState(() {
              _isPlaying = false;
            });
          }
        }
      });
      if (mounted) {
        if (!widget.isPreview!) {
          await _controller!.play();
        }
        setState(() {});
      }
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
      onTap: () {
        if (widget.isPreview!) {
          final videos = locator<ChatStorage>().media;
          final index = videos.indexOf(widget.message);
          SwipeImageGallery(
            context: context,
            initialIndex: index == -1 ? videos.length - 1 : index,
            transitionDuration: 300,
            dismissDragDistance: 100,
            backgroundOpacity: 0.95,
            children: videos
                .map((e) => e.isVideo
                    ? Center(child: VideoMessage(message: e, isPreview: false))
                    : ImageMessage(message: e, isPreview: false))
                .toList(),
            onSwipe: (index) {},
          ).show();
        } else {
          _toggleVideoPlayback();
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: widget.isPreview! ? 10 : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.isPreview! ? 10 : 0),
          color: const Color(0xff423556),
        ),
        constraints: !widget.isPreview!
            ? const BoxConstraints(maxWidth: 1000, maxHeight: 1000)
            : const BoxConstraints(maxWidth: 350, maxHeight: 380),
        child: _controller?.value.isInitialized ?? false
            ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: Stack(
                  children: [
                    ClipRRect(
                        borderRadius:
                            BorderRadius.circular(widget.isPreview! ? 10 : 0),
                        child: VideoPlayer(_controller!)),
                    if (!_controller!.value.isPlaying)
                      Center(child: Assets.icons.playIcon.svg(width: 30)),
                  ],
                ),
              )
            : const AspectRatio(
                aspectRatio: 9 / 16,
                child: Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.white,
                    radius: 18,
                  ),
                ),
              ),
      ),
    );
  }
}
