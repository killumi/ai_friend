import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorageProvider {
  final instance = FirebaseStorage.instance;

  Future<String> getMediaUrl(IChatMessage message) async {
    String url = '';

    if (message.type.toLowerCase().contains('image')) {
      url = await _downloadImage(message.content);
    }

    if (message.type.toLowerCase().contains('video')) {
      url = await _downloadVideo(message.content);
    }

    print('url: $url');
    return url;
  }

  Future<String> _downloadVideo(String assetName) async {
    final ref = instance.ref();
    final results = await ref.child('videos').listAll();
    final item = results.items.firstWhere((e) => e.name.contains(assetName));
    final url = await item.getDownloadURL();
    return url;
  }

  Future<String> _downloadImage(String assetName) async {
    final ref = instance.ref();
    final results = await ref.child('images').listAll();
    final item = results.items.firstWhere((e) => e.name.contains(assetName));
    final url = await item.getDownloadURL();
    return url;
  }
}
