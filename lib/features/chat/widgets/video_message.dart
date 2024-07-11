// // import 'dart:developer';

// // import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
// // import 'package:ai_friend/domain/firebase/fire_storage.dart';
// // import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
// // import 'package:ai_friend/gen/assets.gen.dart';
// // import 'package:ai_friend/locator.dart';
// // import 'package:ai_friend/widgets/blur_widget.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:swipe_image_gallery/swipe_image_gallery.dart';
// // import 'package:video_player/video_player.dart';
// // import 'package:flutter/foundation.dart' show kIsWeb;

// // class VideoMessage extends StatefulWidget {
// //   final IChatMessage message;
// //   final bool? isPreview;

// //   const VideoMessage({required this.message, this.isPreview = true, super.key});

// //   @override
// //   State<VideoMessage> createState() => _VideoMessageState();
// // }

// // class _VideoMessageState extends State<VideoMessage>
// //     with AutomaticKeepAliveClientMixin {
// //   VideoPlayerController? _controller;
// //   bool _isPlaying = true;
// //   final firebaseProvider = locator<FireStorageProvider>();
// //   // bool _isBlurred = true;

// //   @override
// //   bool get wantKeepAlive => true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     // _isBlurred = widget.isPreview!;
// //     _initVideoController();
// //   }

// //   @override
// //   void dispose() {
// //     _controller?.dispose();
// //     super.dispose();
// //   }

// //   // void toggleBlur() {
// //   //   _isBlurred = !_isBlurred;
// //   //   setState(() {});
// //   // }

// //   Future<void> _initVideoController() async {
// //     // if (widget.message.mediaData != null) {
// //     if (widget.message != null) {
// //       // print("VIDEO ======================== +++Hello from build method!");
// //       // if (kIsWeb) {
// //       //   // For web platform, use the network U
// //       // pRL
// //       final url = await firebaseProvider.getMediaUrl(widget.message);
// //       log('INIT WEB VIDEO: $url');
// //       print('INIT WEB VIDEO: $url');
// //       _controller = VideoPlayerController.networkUrl(Uri.parse(url));
// //       // } else {
// //       //   final file = await firebaseProvider.getMediaFile(
// //       //       widget.message.mediaData!, widget.message.content, 'mp4');
// //       //   _controller = VideoPlayerController.file(file);
// //       // }

// //       _controller!.setVolume(0);
// //     } else {
// //       final url = await firebaseProvider.getMediaUrl(widget.message);
// //       _controller = VideoPlayerController.networkUrl(Uri.parse(url));
// //       _controller!.setVolume(0);
// //     }

// //     await _controller!.initialize().then((_) async {
// //       _controller!.addListener(() {
// //         if (!_controller!.value.isPlaying) {
// //           if (mounted) {
// //             setState(() {
// //               _isPlaying = false;
// //             });
// //           }
// //         }
// //       });
// //       if (mounted) {
// //         if (!widget.isPreview!) {
// //           await _controller!.play();
// //         }
// //         setState(() {});
// //       }
// //     });
// //   }

// //   void _toggleVideoPlayback() {
// //     // log('INIT WEB VIDEO:');
// //     // print('INIT WEB VIDEO:');
// //     setState(() {
// //       _isPlaying = !_isPlaying;

// //       if (_isPlaying) {
// //         _controller!.play();
// //       } else {
// //         _controller!.pause();
// //       }
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;

// //     super.build(context);
// //     return Container(
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(widget.isPreview! ? 10 : 0),
// //         color: const Color(0xff423556),
// //       ),
// //       constraints: !widget.isPreview!
// //           ? BoxConstraints(maxWidth: size.width, maxHeight: size.height)
// //           // ? const BoxConstraints(maxWidth: 1000, maxHeight: 1000)
// //           : const BoxConstraints(maxWidth: 350, maxHeight: 380),
// //       child: _controller?.value.isInitialized ?? false
// //           ? AspectRatio(
// //               aspectRatio: _controller!.value.aspectRatio,
// //               child: ClipRRect(
// //                 borderRadius: BorderRadius.circular(widget.isPreview! ? 10 : 0),
// //                 child: Stack(
// //                   fit: StackFit.expand,
// //                   children: [
// //                     BlurWidget(
// //                       onTap: () {
// //                         print('object _______________ LOG TAP VIDEO');
// //                         log('object _______________ LOG TAP VIDEO');
// //                         if (widget.isPreview!) {
// //                           FirebaseAnaliticsService.logOnTapToMessageV();
// //                           SwipeImageGallery(
// //                               context: context,
// //                               initialIndex: 0,
// //                               transitionDuration: 300,
// //                               dismissDragDistance: 100,
// //                               backgroundOpacity: 0.95,
// //                               children: [
// //                                 Center(
// //                                   child: VideoMessage(
// //                                     message: widget.message,
// //                                     isPreview: false,
// //                                   ),
// //                                 ),
// //                               ]).show();
// //                         } else {
// //                           _toggleVideoPlayback();
// //                         }
// //                       },
// //                       showButton: false,
// //                       child: VideoPlayer(_controller!),
// //                     ),
// //                     if (!_controller!.value.isPlaying)
// //                       Center(
// //                         child: IgnorePointer(
// //                           ignoring: true,
// //                           child: Assets.icons.playIcon.svg(width: 30),
// //                         ),
// //                       ),
// //                   ],
// //                 ),
// //               ),
// //             )
// //           : const AspectRatio(
// //               aspectRatio: 9 / 16,
// //               child: Center(
// //                 child: CupertinoActivityIndicator(
// //                   color: Colors.white,
// //                   radius: 18,
// //                 ),
// //               ),
// //             ),
// //     );
// //   }
// // }

// // ==========

// import 'dart:developer';

// import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
// import 'package:ai_friend/domain/firebase/fire_storage.dart';
// import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
// import 'package:ai_friend/gen/assets.gen.dart';
// import 'package:ai_friend/locator.dart';
// import 'package:ai_friend/widgets/blur_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:swipe_image_gallery/swipe_image_gallery.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

// class VideoMessage extends StatefulWidget {
//   final IChatMessage message;
//   final bool? isPreview;

//   const VideoMessage({required this.message, this.isPreview = true, super.key});

//   @override
//   State<VideoMessage> createState() => _VideoMessageState();
// }

// class _VideoMessageState extends State<VideoMessage>
//     with AutomaticKeepAliveClientMixin {
//   VideoPlayerController? _controller;
//   bool _isPlaying = true;
//   final firebaseProvider = locator<FireStorageProvider>();

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();
//     _initVideoController();
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   Future<void> _initVideoController() async {
//     if (widget.message != null) {
//       try {
//         final url = await firebaseProvider.getMediaUrl(widget.message);
//         log('INIT WEB VIDEO: $url');
//         print('INIT WEB VIDEO: $url');
//         _controller = VideoPlayerController.networkUrl(Uri.parse(url));
//         await _controller!.initialize();
//         if (mounted) {
//           _controller!.setVolume(0);
//           if (!widget.isPreview!) {
//             await _controller!.play();
//           }
//           setState(() {});
//         }
//       } catch (e) {
//         log('Error initializing video controller: $e');
//       }
//     }
//   }

//   void _toggleVideoPlayback() {
//     setState(() {
//       _isPlaying = !_isPlaying;
//       if (_isPlaying) {
//         _controller!.play();
//       } else {
//         _controller!.pause();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final size = MediaQuery.of(context).size;
// return Container(
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(widget.isPreview! ? 10 : 0),
//     color: const Color(0xff423556),
//   ),
//   constraints: !widget.isPreview!
//       ? BoxConstraints(maxWidth: size.width, maxHeight: size.height)
//       : const BoxConstraints(maxWidth: 350, maxHeight: 380),
//   child: _controller?.value.isInitialized ?? false
//       ? AspectRatio(
//           aspectRatio: _controller!.value.aspectRatio,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(widget.isPreview! ? 10 : 0),
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 BlurWidget(
//                   onTap: () {
//                     print('object _______________ LOG TAP VIDEO');
//                     log('object _______________ LOG TAP VIDEO');
//                     if (widget.isPreview!) {
//                       FirebaseAnaliticsService.logOnTapToMessageV();
//                       SwipeImageGallery(
//                           context: context,
//                           initialIndex: 0,
//                           transitionDuration: 300,
//                           dismissDragDistance: 100,
//                           backgroundOpacity: 0.95,
//                           children: [
//                             Center(
//                               child: VideoMessage(
//                                 message: widget.message,
//                                 isPreview: false,
//                               ),
//                             ),
//                           ]).show();
//                     } else {
//                       _toggleVideoPlayback();
//                     }
//                   },
//                   showButton: false,
//                   child: VideoPlayer(_controller!),
//                 ),
//                 if (!_controller!.value.isPlaying)
//                   Center(
//                     child: IgnorePointer(
//                       ignoring: true,
//                       child: Assets.icons.playIcon.svg(width: 30),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         )
//       : const AspectRatio(
//           aspectRatio: 9 / 16,
//           child: Center(
//             child: CupertinoActivityIndicator(
//               color: Colors.white,
//               radius: 18,
//             ),
//           ),
//         ),
// );
//   }
// }

// ===================

import 'dart:developer';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/domain/firebase/fire_storage.dart';
import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/locator.dart';
import 'package:ai_friend/widgets/blur_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
      log('VideoPlayerController initialized');
      if (mounted) {
        setState(() {
          _controller!.setVolume(0);
          if (!widget.isPreview!) {
            _controller!.play();
          }
        });
      }
    } catch (e) {
      log('Error initializing video controller: $e');
      if (mounted) {
        setState(() {
          _controller = null;
        });
      }
    }
  }

  void _toggleVideoPlayback() {
    if (_controller == null) return;
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
    return BlurWidget(
      onTap: () {
        log('object _______________ LOG TAP VIDEO');
        print('object _______________ LOG TAP VIDEO');
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
            ],
          ).show();
        } else {
          _toggleVideoPlayback();
        }
      },
      showButton: false,
      child: Container(
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
                  borderRadius:
                      BorderRadius.circular(widget.isPreview! ? 10 : 0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      VideoPlayer(_controller!),
                      if (!_controller!.value.isPlaying)
                        Center(
                          child: IgnorePointer(
                            ignoring: true,
                            child: Assets.icons.playIcon.svg(width: 30),
                          ),
                        ),
                      Positioned.fill(
                        child: Container(
                          color: Colors.transparent,
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
      ),
    );
  }
}
