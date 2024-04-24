import 'package:ai_friend/gallery/gallery_image/gallery_image_grid.dart';
import 'package:ai_friend/gallery/gallery_video/gallery_video_grid.dart';
// import 'package:ai_friend/gallery/test_video.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';

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
              views: const [
                CustomScrollView(
                  slivers: [
                    GalleryImageGrid(),
                  ],
                ),
                CustomScrollView(
                  slivers: [GalleryVideoGrid()],
                ),
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
