import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

Uint8List? testVideoB;

class FireStorageProvider {
  final instance = FirebaseStorage.instance;

  Future<String> getMediaUrl(IChatMessage message) async {
    String url = '';

    if (message.type.toLowerCase().contains('image')) {
      url = await _getDownloadImageURL(message.content);
    }

    if (message.type.toLowerCase().contains('video')) {
      url = await _getDownloadVideoURL(message.content);
    }

    return url;
  }

  Future<String> _getDownloadVideoURL(String assetName) async {
    final ref = instance.ref();
    final results = await ref.child('videos').listAll();
    final item = results.items.firstWhere((e) => e.name.contains(assetName));
    final url = await item.getDownloadURL();
    return url;
  }

  Future<String> _getDownloadImageURL(String assetName) async {
    final ref = instance.ref();
    final results = await ref.child('images').listAll();
    final item = results.items.firstWhere((e) => e.name.contains(assetName));
    final url = await item.getDownloadURL();
    return url;
  }

  Future<File> getMediaFile(Uint8List bytes, String name, String format) async {
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/$name.$format').create();
    file.writeAsBytesSync(bytes);
    return file;
  }

  // Future<Uint8List?> downloadVideo(String assetName) async {
  //   final ref = instance.ref();
  // final results = await ref.child('videos').listAll();
  // final item = results.items.firstWhere((e) => e.name.contains(assetName));
  //   final data = await item.getData();
  //   return data;
  // }

  Future<Uint8List> downloadVideo(String assetName) async {
    // Uint8List? data;
    final Completer<Uint8List> completer = Completer<Uint8List>();
    // TaskState? state;
    final ref = instance.ref();
    final results = await ref.child('videos').listAll();
    final item = results.items.firstWhere((e) => e.name.contains(assetName));

    final appDocDir = await getTemporaryDirectory();
    final filePath = "${appDocDir.path}/$assetName.mp4";
    final file = File(filePath);

    final downloadTask = item.writeToFile(file);
    downloadTask.snapshotEvents.listen((taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          // TODO: Handle this case.
          // state = TaskState.running;
          log('message: TaskState.running');
          break;
        case TaskState.paused:
          // TODO: Handle this case.
          // state = TaskState.paused;

          log('message: TaskState.paused');

          break;
        case TaskState.success:
          log('message: TaskState.success');

          // data = await file.readAsBytes();
          completer.complete(file.readAsBytesSync());
        // state = TaskState.success;
        // TODO: Handle this case.
        // return data;
        // break;
        case TaskState.canceled:
          log('message: TaskState.canceled');
          // state = TaskState.canceled;

          // TODO: Handle this case.
          break;
        case TaskState.error:
          // state = TaskState.error;

          log('message: TaskState.error');

          // TODO: Handle this case.
          break;
      }
    });

    // if (state == TaskState.success) {
    //   return data!;
    // }

    return completer.future;
  }

  Future<Uint8List?> downloadImage(String assetName) async {
    final ref = instance.ref();
    final results = await ref.child('images').listAll();
    final item = results.items.firstWhere((e) => e.name.contains(assetName));
    final data = await item.getData();
    return data;
  }
}
