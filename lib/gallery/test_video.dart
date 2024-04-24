// import 'dart:developer';
// import 'dart:io';
// import 'package:ai_friend/firebase/fire_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:video_player/video_player.dart';

// class MyVideoPlayer extends StatefulWidget {
//   final String videoPath;

//   const MyVideoPlayer({required this.videoPath, Key? key}) : super(key: key);

//   @override
//   _MyVideoPlayerState createState() => _MyVideoPlayerState();
// }

// class _MyVideoPlayerState extends State<MyVideoPlayer> {
//   // late VideoPlayerController _controller;
//   VideoPlayerController? controller;

//   Future<String> getVideoFilePath(String fileName) async {
//     // Получаем директорию документов на устройстве
//     Directory appDocDir = await getApplicationDocumentsDirectory();
//     String appDocPath = appDocDir.path;

//     // Составляем полный путь к файлу видео
//     String videoPath = '$appDocPath/$fileName';

//     return videoPath;
//   }

//   @override
//   void initState() {
//     super.initState();
//     init();
//     // _controller = VideoPlayerController.file(File(widget.videoPath))
//     //   ..initialize().then((_) {
//     //     log('object IS INIT');
//     //     setState(() {});
//     //   });
//   }

//   Future<VideoPlayerController> init() async {
//     controller = VideoPlayerController.file(File.fromRawPath(testVideoB!))
//       ..initialize().then((_) {
//         log('object IS INIT');
//         setState(() {});
//       });
//     return controller!;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     controller?.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: init(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             Container(
//               width: 200,
//               height: 200,
//               color: Colors.red,
//               child: const Center(
//                 child: CupertinoActivityIndicator(),
//               ),
//             );
//           }

//           return VideoPlayer(snapshot.data!);
//         });

//     // _controller.value.isInitialized
//     //     ? VideoPlayer(_controller)
//     //     : Container(
//     //         width: 300,
//     //         height: 300,
//     //         color: Colors.red,
//     //       );
//   }
// }
