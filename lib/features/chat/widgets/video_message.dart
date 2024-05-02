import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/domain/firebase/fire_storage.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/locator.dart';
import 'package:ai_friend/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_animated_blur/pro_animated_blur.dart';
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
  bool _isBlurred = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _isBlurred = widget.isPreview!;
    _initVideoController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void toggleBlur() {
    _isBlurred = !_isBlurred;
    setState(() {});
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
          // final videos = locator<ChatStorage>().media;
          // final index = videos
          //     .indexWhere((e) => e.content.contains(widget.message.content));
          // final index = videos.indexOf(widget.message);
          SwipeImageGallery(
              context: context,
              initialIndex: 0,
              transitionDuration: 300,
              dismissDragDistance: 100,
              backgroundOpacity: 0.95,
              children: [
                Center(
                  child: VideoMessage(
                    message: widget.message,
                    isPreview: false,
                  ),
                ),
              ]
              // children: videos
              //     .map((e) => e.isVideo
              //         ? Center(child: VideoMessage(message: e, isPreview: false))
              //         : ImageMessage(message: e, isPreview: false))
              //     .toList(),
              // onSwipe: (index) {},
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
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(widget.isPreview! ? 10 : 0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      VideoPlayer(_controller!),
                      if (!_controller!.value.isPlaying)
                        Center(child: Assets.icons.playIcon.svg(width: 30)),
                      Positioned.fill(
                        child: IgnorePointer(
                          ignoring: !_isBlurred,
                          child: ProAnimatedBlur(
                            blur: _isBlurred ? 15 : 0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.ease,
                            child: GestureDetector(
                                onTap: () => toggleBlur(),
                                child: Container(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: AnimatedOpacity(
                                      opacity: _isBlurred ? 1 : 0,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.ease,
                                      child: SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: AppButton(
                                          title: 'Unblur',
                                          icon: Assets.icons.proIcon
                                              .svg(width: 23),
                                          onTap: () => toggleBlur(),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
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
