// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final Uint8List data;
  final String name;
  final List<IChatMessage> videos;

  const GalleryVideoItem({
    Key? key,
    required this.index,
    required this.data,
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
    initVideo();
  }

  Future<void> initVideo() async {
    final file =
        await firebaseProvider.getMediaFile(widget.data, widget.name, 'mp4');
    _controller = VideoPlayerController.file(file);
    _controller!.setVolume(0);
    await _controller!.initialize().then((_) async {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller?.value.isInitialized ?? false
        ? Stack(
            fit: StackFit.expand,
            children: [
              BlurWidget(
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
                child: LayoutBuilder(
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
              ),
              IgnorePointer(
                  ignoring: true,
                  child: Center(child: Assets.icons.playIcon.svg(width: 24))),
            ],
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
