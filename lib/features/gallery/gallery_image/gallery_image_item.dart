// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';
import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/domain/firebase/fire_storage.dart';
import 'package:ai_friend/locator.dart';
import 'package:ai_friend/widgets/blur_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:flutter/widgets.dart';

class GalleryImageItem extends StatefulWidget {
  final int index;
  final IChatMessage message;
  final List<IChatMessage> images;

  const GalleryImageItem({
    Key? key,
    required this.index,
    required this.message,
    required this.images,
  }) : super(key: key);

  @override
  State<GalleryImageItem> createState() => _GalleryImageItemState();
}

class _GalleryImageItemState extends State<GalleryImageItem> {
  final firebaseProvider = locator<FireStorageProvider>();
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      imageUrl = await firebaseProvider.getMediaUrl(widget.message);
      setState(() {}); // Обновление состояния для перерисовки виджета
    } catch (e) {
      print('Error loading image URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? BlurWidget(
            fit: StackFit.expand,
            onTap: () => AppRouter.openGalleryImagePageView(
                context, widget.images, widget.index),
            onTapBlur: () => AppRouter.openGalleryImagePageView(
                context, widget.images, widget.index),
            showButton: false,
            child: Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                print('Failed to load image: $error');
                return const Center(
                  child: Text('Failed to load image'),
                );
              },
            ),
          )
        : const Center(
            child: CupertinoActivityIndicator(
              color: Colors.white,
            ),
          );
  }
}
