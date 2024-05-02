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

    await _controller!.initialize().then((_) {
      _controller!.play();
      setState(() {});
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
          borderRadius: BorderRadius.circular(1000),
          border: Border.all(
            width: 4,
            color: const Color(0xff423556),
          ),
          color: const Color(0xff423556),
        ),
        height: 230,
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
                            final aspect =
                                constraints.maxWidth / constraints.maxHeight;
                            return OverflowBox(
                              maxHeight: aspect > _controller!.value.aspectRatio
                                  ? double.infinity
                                  : null,
                              maxWidth: aspect < _controller!.value.aspectRatio
                                  ? double.infinity
                                  : null,
                              child: AspectRatio(
                                aspectRatio: _controller!.value.aspectRatio,
                                child: VideoPlayer(
                                  _controller!,
                                ),
                              ),
                            );
                          },
                        )),
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
    );
  }
}
