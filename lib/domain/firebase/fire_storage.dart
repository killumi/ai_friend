import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FireStorage {
  final instance = FirebaseStorage.instance;

  Future<String> getMediaUrl(String src, IChatMessage message) async {
    final ref = instance.ref();

    String url = '';

    try {
      if (message.isImage) {
        url = await _getDownloadImageURL(src, message.content);
      }

      if (message.isVideo) {
        url = await ref.child("$src/${message.content}.mp4").getDownloadURL();
      }
    } catch (e) {
      log('Error fetching media URL: $e');
    }

    // log('Fetched media URL: $url');
    return url;
  }

  Future<String> _getDownloadImageURL(String src, String assetName) async {
    try {
      final ref = instance.ref();
      final results = await ref.child(src).listAll();

      final item = results.items.firstWhere(
        (e) => e.fullPath.contains(assetName),
        orElse: () {
          log('Image with name $assetName not found');
          throw Exception('Image with name $assetName not found');
        },
      );
      log('IMAGE FROM FIRE STOREgA ITEM: $item');
      final url = await item.getDownloadURL();
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

  Future<Uint8List?> downloadVideo(String src, String assetName) async {
    final Completer<Uint8List> completer = Completer<Uint8List>();
    try {
      final ref = instance.ref();
      final item = ref.child("$src/$assetName.mp4");
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
            // completer.completeError('Task was canceled');
            break;
          case TaskState.error:
            // completer.completeError('Task encountered an error');
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
      final item = results.items.firstWhere(
        (e) => e.fullPath.contains(assetName),
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
