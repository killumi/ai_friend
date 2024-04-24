// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';
import 'package:ai_friend/chat/widgets/image_message.dart';
import 'package:ai_friend/chat/widgets/video_message.dart';
import 'package:ai_friend/firebase/fire_storage.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
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

class _GalleryVideoItemState extends State<GalleryVideoItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
    super.build(context);

    return GestureDetector(
      onTap: () {
        SwipeImageGallery(
          context: context,
          initialIndex: widget.index,
          transitionDuration: 300,
          dismissDragDistance: 100,
          backgroundOpacity: 0.95,
          children: widget.videos
              .map((e) =>
                  Center(child: VideoMessage(message: e, isPreview: false)))
              .toList(),
          onSwipe: (index) {},
        ).show();
      },
      child: _controller?.value.isInitialized ?? false
          ? Stack(
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
                if (!_controller!.value.isPlaying)
                  Center(child: Assets.icons.playIcon.svg(width: 24)),
              ],
            )
          : const AspectRatio(
              aspectRatio: 1,
              child: Center(
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  // radius: 18,
                ),
              ),
            ),
    );
  }
}
