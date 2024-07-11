// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/domain/firebase/fire_storage.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/locator.dart';
import 'package:ai_friend/widgets/blur_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class GalleryVideoPage extends StatefulWidget {
  // final Uint8List data;
  final String name;
  final IChatMessage message;

  const GalleryVideoPage({
    Key? key,
    // required this.data,
    required this.name,
    required this.message,
  }) : super(key: key);

  @override
  State<GalleryVideoPage> createState() => _GalleryVideoPageState();
}

class _GalleryVideoPageState extends State<GalleryVideoPage> {
  VideoPlayerController? _controller;
  final firebaseProvider = locator<FireStorageProvider>();
  bool isPlaying = true;
  // VideoPlayerController? _controller;
  // final firebaseProvider = locator<FireStorageProvider>();

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
      await _controller!.play();
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
  // @override
  // void initState() {
  //   super.initState();
  //   initVideo();
  // }

  // Future<void> initVideo() async {
  //   final file =
  //       await firebaseProvider.getMediaFile(widget.data, widget.name, 'mp4');
  //   _controller = VideoPlayerController.file(file);
  //   _controller!.setVolume(0);
  //   await _controller!.initialize().then(
  //     (_) async {
  //       if (mounted) {
  //         if (locator<PaymentProvider>().isHasPremium) {
  //           await _controller?.play();
  //           isPlaying = true;
  //           setState(() {});
  //         }
  //         setState(() {});
  //       }
  //     },
  //   );
  //   _controller!.addListener(
  //     () {
  //       if (!_controller!.value.isPlaying) {
  //         if (mounted) {
  //           isPlaying = false;
  //           setState(() {});
  //         }
  //       }
  //     },
  //   );
  // }

  Future<void> _toggleVideoPlayback() async {
    if (isPlaying) {
      await _controller!.pause();
      isPlaying = false;
    } else {
      await _controller!.play();
      isPlaying = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _controller?.value.isInitialized ?? false
        ? LayoutBuilder(
            builder: (context, constraints) {
              final aspect = constraints.maxWidth / constraints.maxHeight;
              return AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: ClipRRect(
                  child: OverflowBox(
                    maxHeight: aspect > _controller!.value.aspectRatio
                        ? double.infinity
                        : null,
                    maxWidth: aspect < _controller!.value.aspectRatio
                        ? size.width
                        : null,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: BlurWidget(
                          onTap: _toggleVideoPlayback,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              VideoPlayer(_controller!),
                              if (!isPlaying)
                                Center(
                                    child:
                                        Assets.icons.playIcon.svg(width: 24)),
                              Positioned.fill(
                                  child: Container(
                                color: Colors.transparent,
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : const SizedBox();
  }
}
