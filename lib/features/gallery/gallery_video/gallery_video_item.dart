// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:typed_data';
import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/domain/firebase/fire_storage.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/locator.dart';
import 'package:ai_friend/widgets/blur_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
// import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class GalleryVideoItem extends StatefulWidget {
  final int index;
  // final Uint8List data;

  final IChatMessage message;
  final String name;
  final List<IChatMessage> videos;

  const GalleryVideoItem({
    Key? key,
    required this.index,
    required this.message,
    required this.videos,
    required this.name,
  }) : super(key: key);

  @override
  State<GalleryVideoItem> createState() => _GalleryVideoItemState();
}

class _GalleryVideoItemState extends State<GalleryVideoItem> {
  VideoPlayerController? _controller;
  final firebaseProvider = locator<FireStorageProvider>();

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
    try {
      final url = await firebaseProvider.getMediaUrl(widget.message);
      log('INIT WEB VIDEO: $url');
      if (url.isEmpty) {
        log('INIT VIDEO ERROR NULL URL');
        return;
      }
      _controller = VideoPlayerController.networkUrl(Uri.parse(url));
      log('VideoPlayerController created');
      await _controller!.initialize();
      setState(() {});
      log('VideoPlayerController initialized');
    } catch (e) {
      log('Error initializing video controller: $e');
      if (mounted) {
        setState(() {
          _controller = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller?.value.isInitialized ?? false
        ? BlurWidget(
            showButton: false,
            onTapBlur: () => AppRouter.openGalleryVideoPageView(
              context,
              widget.videos,
              widget.index,
            ),
            onTap: () => AppRouter.openGalleryVideoPageView(
              context,
              widget.videos,
              widget.index,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final aspect = constraints.maxWidth / constraints.maxHeight;
                    return AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        child: OverflowBox(
                          maxHeight: aspect > _controller!.value.aspectRatio
                              ? double.infinity
                              : null,
                          maxWidth: aspect < _controller!.value.aspectRatio
                              ? double.infinity
                              : null,
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: Center(child: VideoPlayer(_controller!)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                IgnorePointer(
                    ignoring: true,
                    child: Center(child: Assets.icons.playIcon.svg(width: 24))),
                Positioned.fill(
                    child: Container(
                  color: Colors.transparent,
                ))
              ],
            ),
          )
        : const AspectRatio(
            aspectRatio: 1,
            child: Center(
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            ),
          );
  }
}
