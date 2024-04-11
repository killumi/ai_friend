import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/firebase/fire_storage.dart';
import 'package:ai_friend/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PicMessage extends StatefulWidget {
  final IChatMessage message;
  const PicMessage({required this.message, super.key});

  @override
  State<PicMessage> createState() => _PicMessageState();
}

class _PicMessageState extends State<PicMessage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  IChatMessage get message => widget.message;
  // <String> get url async => message.content;

  late String url;
  ImageStream? _imageStream;
  ImageProvider<Object>? _imageProvider;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void dispose() {
    _imageStream?.removeListener(ImageStreamListener(_updateImage));
    super.dispose();
  }

  void _loadImage() async {
    url = await locator<FireStorageProvider>().getMediaUrl(message);
    // setState(() {});
    final imageStreamProvider = NetworkImage(url);
    _imageStream = imageStreamProvider.resolve(ImageConfiguration.empty);
    _imageStream?.addListener(ImageStreamListener(_updateImage));
  }

  void _updateImage(ImageInfo info, bool synchronousCall) {
    setState(() {
      _imageProvider = NetworkImage(url);
    });
  }

  // =========================
  // =========================
  // =========================

  // late ImageStream _imageStream;
  // Image? _image;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadImage();
  // }

  // @override
  // void dispose() {
  //   _imageStream.removeListener(ImageStreamListener(_updateImage));
  //   super.dispose();
  // }

  // void _loadImage() {
  //   final imageStreamProvider = NetworkImage(url);
  //   _imageStream = imageStreamProvider.resolve(ImageConfiguration.empty);
  //   _imageStream.addListener(ImageStreamListener(_updateImage));
  // }

  // void _updateImage(ImageInfo info, bool synchronousCall) {
  //   setState(() {
  //     _image = Image(image: info.image, fit: BoxFit.cover);
  //   });
  // }

// =====================
// =====================
// =====================
  // Image? _image;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadImage();
  // }

  // Future<void> _loadImage() async {
  //   final url = await locator<FireStorageProvider>().getMediaUrl(message);
  //   _initImage(url);
  // }

  // void _initImage(String url) {
  //   final image = Image.network(
  //     url,
  //     fit: BoxFit.cover,
  //   );

  //   precacheImage(image.image, context);
  //   _image = image;
  //   setState(() {});
  // }

  void showSnack(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 12),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        showSnack(
          context,
          'Добавить отображение с зумом (кстати можно платно) и сохранение фото тоже только платно',
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.greenAccent,
        ),
        height: 400,
        child: _imageProvider != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                    aspectRatio: 9 / 13,
                    child: Image(image: _imageProvider!, fit: BoxFit.cover)))
            : const AspectRatio(
                aspectRatio: 9 / 13,
                child: Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.black,
                    radius: 18,
                  ),
                ),
              ),
      ),
    );
  }
}
