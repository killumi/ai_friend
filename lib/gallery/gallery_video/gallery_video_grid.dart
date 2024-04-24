import 'dart:math';

import 'package:ai_friend/chat/chat_storage.dart';
import 'package:ai_friend/gallery/gallery_video/gallery_video_item.dart';
import 'package:ai_friend/locator.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GalleryVideoGrid extends StatelessWidget {
  const GalleryVideoGrid({super.key});

  Color randomColor() =>
      Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: locator<ChatStorage>().box.listenable(),
      builder: (context, box, widget) {
        final videos = locator<ChatStorage>().videos;

        return SliverPadding(
          padding: const EdgeInsets.only(top: 10),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => AspectRatio(
                aspectRatio: 1,
                child: GalleryVideoItem(
                    index: index,
                    data: videos[index].mediaData!,
                    name: videos[index].content,
                    videos: videos),
              ),
              childCount: videos.length,
            ),
          ),
        );
      },
    );
  }
}
