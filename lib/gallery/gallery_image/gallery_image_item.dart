// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:ai_friend/chat/widgets/image_message.dart';
import 'package:flutter/material.dart';

import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

class GalleryImageItem extends StatelessWidget {
  final int index;
  final Uint8List data;
  final List<IChatMessage> images;

  const GalleryImageItem({
    Key? key,
    required this.index,
    required this.data,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SwipeImageGallery(
          context: context,
          initialIndex: index,
          transitionDuration: 300,
          dismissDragDistance: 100,
          backgroundOpacity: 0.95,
          children: images
              .map((e) => ImageMessage(message: e, isPreview: false))
              .toList(),
          onSwipe: (index) {},
        ).show();
      },
      child: Image.memory(
        data,
        fit: BoxFit.cover,
      ),
    );
  }
}
