import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';

class FireStorage {
  final instance = FirebaseStorage.instance;

  Future<String> getMediaUrl(String src, IChatMessage message) async {
    final ref = instance.ref();

    String url = '';

    try {
      if (message.isImage) {
        url = await _getDownloadImageURL(src, message.content);
        // url = await ref.child("$src/${message.content}.png").getDownloadURL();
      }

      if (message.isVideo) {
        url = await ref.child("$src/${message.content}.mp4").getDownloadURL();
      }
    } catch (e) {
      log('Error fetching media URL: $e');
    }

    log('Fetched media URL: $url');
    return url;
  }

  Future<String> _getDownloadImageURL(String src, String assetName) async {
    try {
      final ref = instance.ref();
      final results = await ref.child(src).listAll();
      log('Listing all items in $src');
      results.items.forEach((item) {
        log('ITEM: ${item.fullPath}');
      });
      final item = results.items.firstWhere(
        (e) => e.fullPath.contains(assetName),
        orElse: () {
          log('Image with name $assetName not found');
          throw Exception('Image with name $assetName not found');
        },
      );
      final url = await item.getDownloadURL();
      log('Image URL: $url');
      return url;
    } catch (e) {
      log('Error fetching image URL: $e');
      throw Exception('Error fetching image URL: $e');
    }
  }

  Future<File> getMediaFile(Uint8List bytes, String name, String format) async {
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/$name.$format').create();
    file.writeAsBytesSync(bytes);
    return file;
  }

  Future<Uint8List> downloadVideo(String src, String assetName) async {
    final Completer<Uint8List> completer = Completer<Uint8List>();
    try {
      final ref = instance.ref();
      final results = await ref.child(src).listAll();
      log('Listing all items in $src');
      results.items.forEach((item) {
        log('ITEM: ${item.fullPath}');
      });
      final item = results.items.firstWhere(
        (e) => e.name == assetName,
        orElse: () {
          log('Video with name $assetName not found');
          throw Exception('Video with name $assetName not found');
        },
      );
      log('TRY DOWNLOAD VIDEO: ${results.items.length}');

      final appDocDir = await getTemporaryDirectory();
      final filePath = "${appDocDir.path}/$assetName.mp4";
      final file = File(filePath);

      final downloadTask = item.writeToFile(file);
      downloadTask.snapshotEvents.listen((taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.success:
            completer.complete(file.readAsBytesSync());
            break;
          case TaskState.canceled:
            completer.completeError('Task was canceled');
            break;
          case TaskState.error:
            completer.completeError('Task encountered an error');
            break;
        }
      });
    } catch (e) {
      log('Error downloading video: $e');
      completer.completeError('Error downloading video: $e');
    }

    return completer.future;
  }

  Future<Uint8List?> downloadImage(String src, String assetName) async {
    try {
      final ref = instance.ref();
      final results = await ref.child(src).listAll();
      log('Listing all items in $src');
      results.items.forEach((item) {
        log('ITEM: ${item.fullPath}');
      });
      final item = results.items.firstWhere(
        (e) => e.name == assetName,
        orElse: () {
          log('Image with name $assetName not found');
          throw Exception('Image with name $assetName not found');
        },
      );
      final data = await item.getData();
      return data;
    } catch (e) {
      log('Error downloading image: $e');
      return null;
    }
  }
}


// class FireStorage {
//   final instance = FirebaseStorage.instance;

//   Future<String> getMediaUrl(String src, IChatMessage message) async {
//     String url = '';

//     try {
//       if (message.type.toLowerCase().contains('image')) {
//         url = await _getDownloadImageURL(src, message.content);
//       }

//       if (message.type.toLowerCase().contains('video')) {
//         url = await _getDownloadVideoURL(src, message.content);
//       }
//     } catch (e) {
//       log('Error fetching media URL: $e');
//     }

//     return url;
//   }

//   Future<String> _getDownloadVideoURL(String src, String assetName) async {
//     try {
//       final ref = instance.ref();
//       final results = await ref.child(src).listAll();
//       final item = results.items.firstWhere(
//         (e) => e.name.contains(assetName),
//         orElse: () => throw Exception('Video with name $assetName not found'),
//       );
//       final url = await item.getDownloadURL();
//       log('VIDEO DOWNLOAD URL ___________________: $url');
//       return url;
//     } catch (e) {
//       log('Error fetching video URL: $e');
//       throw Exception('Error fetching video URL: $e');
//     }
//   }

//   Future<String> _getDownloadImageURL(String src, String assetName) async {
//     try {
//       final ref = instance.ref();
//       final results = await ref.child(src).listAll();
//       final item = results.items.firstWhere(
//         (e) => e.name.contains(assetName),
//         orElse: () => throw Exception('Image with name $assetName not found'),
//       );
//       final url = await item.getDownloadURL();
//       return url;
//     } catch (e) {
//       log('Error fetching image URL: $e');
//       throw Exception('Error fetching image URL: $e');
//     }
//   }

//   Future<File> getMediaFile(Uint8List bytes, String name, String format) async {
//     final tempDir = await getTemporaryDirectory();
//     final file = await File('${tempDir.path}/$name.$format').create();
//     file.writeAsBytesSync(bytes);
//     return file;
//   }

//   Future<Uint8List> downloadVideo(String src, String assetName) async {
//     final Completer<Uint8List> completer = Completer<Uint8List>();
//     try {
//       final ref = instance.ref();
//       final results = await ref.child(src).listAll();
//       log('ASSEt NAME: $assetName');
//       log('TRY DOWNLOAD VIDEO: ${results.items.length}');

//       final item = results.items.firstWhere(
//         (e) => e.fullPath.contains(assetName),
//         orElse: () => throw Exception('Video with name $assetName not found'),
//       );

//       final appDocDir = await getTemporaryDirectory();
//       final filePath = "${appDocDir.path}/$assetName.mp4";
//       final file = File(filePath);

//       final downloadTask = item.writeToFile(file);
//       downloadTask.snapshotEvents.listen((taskSnapshot) async {
//         switch (taskSnapshot.state) {
//           case TaskState.running:
//             break;
//           case TaskState.paused:
//             break;
//           case TaskState.success:
//             completer.complete(file.readAsBytesSync());
//             break;
//           case TaskState.canceled:
//             completer.completeError('Task was canceled');
//             break;
//           case TaskState.error:
//             completer.completeError('Task encountered an error');
//             break;
//         }
//       });
//     } catch (e) {
//       log('Error downloading video: $e');
//       completer.completeError('Error downloading video: $e');
//     }

//     return completer.future;
//   }

//   Future<Uint8List?> downloadImage(String src, String assetName) async {
//     try {
//       final ref = instance.ref();
//       final results = await ref.child(src).listAll();
//       log('ASSEt NAME: $assetName');
//       log('TRY DOWNLOAD IMAGE: ${results.items.length}');
//       final item = results.items.firstWhere(
//         (e) => e.name.contains(assetName),
//         orElse: () => throw Exception('Image with name $assetName not found'),
//       );
//       final data = await item.getData();
//       return data;
//     } catch (e) {
//       log('Error downloading image: $e');
//       return null;
//     }
//   }

//   Future<void> checkImages() async {
//     final ref = instance.ref();
//     final results = await ref.child('alice/chat_videos').listAll();
//     for (var e in results.items) {
//       log('ITEM: $e');
//     }
//     log('TRY DOWNLOAD IMAGE: ${results.items.length}');
//   }
// }


// ======
// ======
// ======
// ======
// ======
// ======
// ======
// ======

// class FireStorage {
//   final instance = FirebaseStorage.instance;

//   Future<String> getMediaUrl(String src, IChatMessage message) async {
//     String url = '';

//     if (message.type.toLowerCase().contains('image')) {
//       url = await _getDownloadImageURL(src, message.content);
//     }

//     if (message.type.toLowerCase().contains('video')) {
//       url = await _getDownloadVideoURL(src, message.content);
//     }

//     return url;
//   }

//   Future<String> _getDownloadVideoURL(
//     String src,
//     String assetName,
//   ) async {
//     final ref = instance.ref();
//     final results = await ref.child(src).listAll();
//     final item = results.items.firstWhere((e) => e.name.contains(assetName));
//     final url = await item.getDownloadURL();
//     log('VIDEO URL: $url');
//     return url;
//   }

//   Future<String> _getDownloadImageURL(
//     String src,
//     String assetName,
//   ) async {
//     final ref = instance.ref();
//     final results = await ref.child(src).listAll();
//     final item = results.items.firstWhere((e) => e.name.contains(assetName));
//     final url = await item.getDownloadURL();
//     log('IMAGE URL: $url');
//     return url;
//   }

//   Future<File> getMediaFile(Uint8List bytes, String name, String format) async {
//     final tempDir = await getTemporaryDirectory();
//     final file = await File('${tempDir.path}/$name.$format').create();
//     file.writeAsBytesSync(bytes);
//     return file;
//   }

//   Future<Uint8List> downloadVideo(String src, String assetName) async {
//     final Completer<Uint8List> completer = Completer<Uint8List>();
//     final ref = instance.ref();
//     final results = await ref.child(src).listAll();
//     final item = results.items.firstWhere((e) => e.name.contains(assetName));
//     log('TRY DOWNLOAD VIDEO: ${results.items.length}');

//     final appDocDir = await getTemporaryDirectory();
//     final filePath = "${appDocDir.path}/$assetName.mp4";
//     final file = File(filePath);

//     final downloadTask = item.writeToFile(file);
//     downloadTask.snapshotEvents.listen((taskSnapshot) async {
//       switch (taskSnapshot.state) {
//         case TaskState.running:
//           break;
//         case TaskState.paused:
//           break;
//         case TaskState.success:
//           completer.complete(file.readAsBytesSync());
//           // state = TaskState.success;
//           // return data;
//           break;
//         case TaskState.canceled:
//           // log('message: TaskState.canceled');
//           // state = TaskState.canceled;
//           break;
//         case TaskState.error:
//           // state = TaskState.error;
//           // log('message: TaskState.error');
//           break;
//       }
//     });

//     return completer.future;
//   }

//   Future<Uint8List?> downloadImage(String src, String assetName) async {
//     final ref = instance.ref();
//     final results = await ref.child(src).listAll();
//     log('TRY DOWNLOAD IMAGE: ${results.items.length}');
//     final item = results.items.firstWhere((e) => e.name.contains(assetName));
//     final data = await item.getData();
//     return data;
//   }

  // Future<void> checkImages() async {
  //   final ref = instance.ref();
  //   final results = await ref.child('alice/chat_videos').listAll();
  //   log('TRY DOWNLOAD IMAGE: ${results.items.length}');
  // }
// }

// ===========================
// ===========================
// ===========================

// class FireStorage {
//   final instance = FirebaseStorage.instance;

//   Future<String> getMediaUrl(IChatMessage message) async {
//     String url = '';

//     if (message.type.toLowerCase().contains('image')) {
//       url = await _getDownloadImageURL(message.content);
//     }

//     if (message.type.toLowerCase().contains('video')) {
//       url = await _getDownloadVideoURL(message.content);
//     }

//     return url;
//   }

//   Future<String> _getDownloadVideoURL(String assetName) async {
//     final ref = instance.ref();
//     final results = await ref.child('videos').listAll();
//     final item = results.items.firstWhere((e) => e.name.contains(assetName));
//     final url = await item.getDownloadURL();
//     return url;
//   }

//   Future<String> _getDownloadImageURL(String assetName) async {
//     final ref = instance.ref();
//     final results = await ref.child('images').listAll();
//     final item = results.items.firstWhere((e) => e.name.contains(assetName));
//     final url = await item.getDownloadURL();
//     return url;
//   }

//   Future<File> getMediaFile(Uint8List bytes, String name, String format) async {
//     final tempDir = await getTemporaryDirectory();
//     final file = await File('${tempDir.path}/$name.$format').create();
//     file.writeAsBytesSync(bytes);
//     return file;
//   }

//   Future<Uint8List> downloadVideo(String assetName) async {
//     final Completer<Uint8List> completer = Completer<Uint8List>();
//     final ref = instance.ref();
//     final results = await ref.child('videos').listAll();
//     final item = results.items.firstWhere((e) => e.name.contains(assetName));

//     final appDocDir = await getTemporaryDirectory();
//     final filePath = "${appDocDir.path}/$assetName.mp4";
//     final file = File(filePath);

//     final downloadTask = item.writeToFile(file);
//     downloadTask.snapshotEvents.listen((taskSnapshot) async {
//       switch (taskSnapshot.state) {
//         case TaskState.running:
//           break;
//         case TaskState.paused:
//           break;
//         case TaskState.success:
//           completer.complete(file.readAsBytesSync());
//           // state = TaskState.success;
//           // return data;
//           break;
//         case TaskState.canceled:
//           // log('message: TaskState.canceled');
//           // state = TaskState.canceled;
//           break;
//         case TaskState.error:
//           // state = TaskState.error;
//           // log('message: TaskState.error');
//           break;
//       }
//     });

//     return completer.future;
//   }

//   Future<Uint8List?> downloadImage(String assetName) async {
//     final ref = instance.ref();
//     final results = await ref.child('images').listAll();
//     final item = results.items.firstWhere((e) => e.name.contains(assetName));
//     final data = await item.getData();
//     return data;
//   }
// }
