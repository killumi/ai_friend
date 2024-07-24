import 'package:ai_friend/features/gallery/gallery_image/gallery_image_grid.dart';
import 'package:ai_friend/features/gallery/gallery_video/gallery_video_grid.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/widgets/app_header.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:ai_friend/features/chat/chat_storage.dart';
import 'package:ai_friend/domain/services/locator.dart';
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

  Widget _buildAppbar() =>
      const AppHeader(title: 'Gallery', showBackButton: true);
}
