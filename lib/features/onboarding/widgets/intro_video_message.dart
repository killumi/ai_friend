import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/features/onboarding/onboarding_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class IntroVideoMessage extends StatefulWidget {
  final OnboardingMessage message;

  const IntroVideoMessage({required this.message, super.key});

  @override
  State<IntroVideoMessage> createState() => _IntroVideoMessageState();
}

class _IntroVideoMessageState extends State<IntroVideoMessage>
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
    _controller = VideoPlayerController.asset(widget.message.videoAsset!);

    try {
      await _controller!.initialize().then((_) {
        if (mounted) {
          print('Video initialized');
          // _controller!.setLooping(true);
          // _controller!.play();
          setState(() {});
        }
      });
    } catch (e) {
      print('Error initializing video: $e');
    }

    _controller!.addListener(() {
      if (_controller!.value.hasError) {
        print('Video player error: ${_controller!.value.errorDescription}');
      }
      if (!_controller!.value.isPlaying) {
        if (mounted) {
          _isPlaying = false;
          setState(() {});
        }
      }
    });
  }

  Future<void> _toggleVideoPlayback() async {
    if (_isPlaying) {
      await _controller!.pause();
      _isPlaying = false;
    } else {
      await _controller!.play();
      _isPlaying = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: _toggleVideoPlayback,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                border: Border.all(
                  width: 4,
                  color: const Color(0xff423556),
                ),
                color: const Color(0xff423556),
              ),
              height: 300,
              child: _controller?.value.isInitialized ?? false
                  ? AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                final aspect = constraints.maxWidth /
                                    constraints.maxHeight;
                                return OverflowBox(
                                  maxHeight:
                                      aspect > _controller!.value.aspectRatio
                                          ? double.infinity
                                          : null,
                                  maxWidth:
                                      aspect < _controller!.value.aspectRatio
                                          ? double.infinity
                                          : null,
                                  child: AspectRatio(
                                    aspectRatio: _controller!.value.aspectRatio,
                                    child: VideoPlayer(_controller!),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (!_controller!.value.isPlaying)
                            Center(child: Assets.icons.playIcon.svg(width: 30)),
                        ],
                      ),
                    )
                  : const AspectRatio(
                      aspectRatio: 1,
                      child: Center(
                        child: CupertinoActivityIndicator(
                          color: Colors.white,
                          radius: 18,
                        ),
                      ),
                    ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
