import 'dart:developer';

import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/domain/firebase/fire_storage.dart';
import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
import 'package:ai_friend/features/assistants/assistants_provider.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/domain/services/locator.dart';
import 'package:ai_friend/widgets/blur_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final fireStorage = locator<FireStorage>();

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
    log('START INIT VIDEO');
    if (widget.message.mediaData != null) {
      log('START INIT VIDEO WITH UNTI8LIST AS FILE');
      final file = await fireStorage.getMediaFile(
          widget.message.mediaData!, widget.message.content, 'mp4');
      _controller = VideoPlayerController.file(file);
      _controller!.setVolume(0);
    } else {
      log('START INIT VIDEO WITH URL');

      final src =
          context.read<AssistantsProvider>().currentAssistant!.chatVideosSrc;
      log('CURRENT SRC: $src');
      final url = await fireStorage.getMediaUrl(src, widget.message);
      log('VIDEO URL: $url ');

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
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.isPreview! ? 10 : 0),
        color: const Color(0xff423556),
      ),
      constraints: !widget.isPreview!
          ? BoxConstraints(maxWidth: size.width, maxHeight: size.height)
          : const BoxConstraints(maxWidth: 350, maxHeight: 380),
      child: _controller?.value.isInitialized ?? false
          ? AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.isPreview! ? 10 : 0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    BlurWidget(
                      onTap: () {
                        if (widget.isPreview!) {
                          FirebaseAnaliticsService.logOnTapToMessageV();
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
                              ]).show();
                        } else {
                          _toggleVideoPlayback();
                        }
                      },
                      showButton: false,
                      child: VideoPlayer(_controller!),
                    ),
                    if (!_controller!.value.isPlaying)
                      Center(
                        child: IgnorePointer(
                          ignoring: true,
                          child: Assets.icons.playIcon.svg(width: 30),
                        ),
                      ),
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
    );
  }
}
