// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/domain/firebase/fire_storage.dart';
import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
import 'package:ai_friend/features/gallery/gallery_header.dart';
import 'package:ai_friend/features/gallery/gallery_video/gallery_video_page.dart';
import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:ai_friend/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class GalleryVideoPageView extends StatefulWidget {
  final List<IChatMessage> videos;
  final int initialIndex;

  const GalleryVideoPageView({
    Key? key,
    required this.videos,
    required this.initialIndex,
  }) : super(key: key);

  @override
  State<GalleryVideoPageView> createState() => _GalleryVideoPageViewState();
}

class _GalleryVideoPageViewState extends State<GalleryVideoPageView> {
  late PageController _pageController;
  double _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.toDouble();
    _pageController = PageController(initialPage: widget.initialIndex);
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void next() {
    HapticFeedback.mediumImpact();
    if (_currentIndex == widget.videos.length - 1) {
      _pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 10),
        curve: Curves.ease,
      );
      return;
    }

    _pageController.animateToPage(
      _currentIndex.toInt() + 1,
      duration: const Duration(milliseconds: 10),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isHasPremium = context.select((PaymentProvider e) => e.isHasPremium);
    // final isSmal = MediaQuery.of(context).size.height < 750;

    return ScreenWrap(
      child: SafeArea(
        top: false,
        child: Stack(
          children: [
            Column(
              children: [
                GalleryHeader(
                  currentIndex: _currentIndex,
                  totalLength: widget.videos.length,
                  onSave: () async {
                    FirebaseAnaliticsService.logOnSaveV();
                    if (widget.videos[_currentIndex.toInt()].mediaData ==
                        null) {
                      return;
                    }
                    if (!isHasPremium) {
                      AppRouter.openPaywall(context, false);
                      return;
                    }
                    final bytes =
                        widget.videos[_currentIndex.toInt()].mediaData!;
                    final name = widget.videos[_currentIndex.toInt()].content;

                    final file = await locator<FireStorageProvider>()
                        .getMediaFile(bytes, name, 'mp4');

                    await ImageGallerySaver.saveFile(file.path, name: name);
                    showToast(
                      'Video was saved',
                      textPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      position: ToastPosition.center,
                      duration: const Duration(seconds: 3),
                      animationCurve: Curves.ease,
                    );
                  },
                ),
                Expanded(
                  child: PageView.builder(
                    itemCount: widget.videos.length,
                    controller: _pageController,
                    onPageChanged: (e) {
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GalleryVideoPage(
                              key: PageStorageKey(widget.videos[index].content),
                              // data: widget.videos[index].mediaData!,
                              name: widget.videos[index].content,
                              message: widget.videos[index],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
