// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';
import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/widgets/blur_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:flutter/widgets.dart';

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
    return BlurWidget(
      fit: StackFit.expand,
      onTap: () => AppRouter.openGalleryImagePageView(context, images, index),
      onTapBlur: () =>
          AppRouter.openGalleryImagePageView(context, images, index),
      showButton: false,
      child: Image.memory(
        data,
        fit: BoxFit.cover,
      ),
    );
  }
}
