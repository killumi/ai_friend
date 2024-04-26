import 'package:ai_friend/gallery/gallery_image/gallery_image_grid.dart';
import 'package:ai_friend/gallery/gallery_video/gallery_video_grid.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:ai_friend/chat/chat_storage.dart';
import 'package:ai_friend/gallery/gallery_image/gallery_image_item.dart';
import 'package:ai_friend/locator.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenWrap(
      child: Column(
        children: [
          _buildAppbar(),
          Expanded(
            child: ContainedTabBarView(
              tabBarProperties:
                  const TabBarProperties(indicatorColor: Color(0xffB549B8)),
              tabs: const [
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Photo',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: FontFamily.gothamPro,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Video',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: FontFamily.gothamPro,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
              views: [
                ValueListenableBuilder(
                    valueListenable: locator<ChatStorage>().box.listenable(),
                    builder: (context, box, widget) {
                      final images = locator<ChatStorage>().images;
                      return images.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.icons.galleryIcon.svg(
                                  width: 48,
                                  color: const Color(0xffA9A1B2),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  "Alice hasn't sent her photos yet",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffA9A1B2),
                                    fontFamily: FontFamily.gothamPro,
                                  ),
                                ),
                                const SizedBox(height: 100),
                              ],
                            )
                          : CustomScrollView(
                              slivers: [
                                GalleryImageGrid(images: images),
                              ],
                            );
                    }),
                // CustomScrollView(
                //   slivers: [
                //     GalleryImageGrid(),
                //   ],
                // ),
                ValueListenableBuilder(
                    valueListenable: locator<ChatStorage>().box.listenable(),
                    builder: (context, box, widget) {
                      final videos = locator<ChatStorage>().videos;

                      return videos.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Assets.icons.galleryIcon.svg(
                                  width: 48,
                                  color: const Color(0xffA9A1B2),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  "Alice hasn't sent her videos yet",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffA9A1B2),
                                    fontFamily: FontFamily.gothamPro,
                                  ),
                                ),
                                const SizedBox(height: 100),
                              ],
                            )
                          : CustomScrollView(
                              slivers: [GalleryVideoGrid(videos: videos)],
                            );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppbar() => Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        decoration: const ShapeDecoration(
          color: Color(0xFF170C22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        child: const SafeArea(
          bottom: false,
          child: Text(
            'Gallery',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFFBFBFB),
              fontSize: 20,
              fontFamily: FontFamily.gothamPro,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      );
}
