import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/domain/firebase/fire_storage.dart';
import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
import 'package:ai_friend/features/gallery/gallery_header.dart';
import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:ai_friend/locator.dart';
import 'package:ai_friend/widgets/blur_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class GalleryImagePageView extends StatefulWidget {
  final List<IChatMessage> images;
  final int initialIndex;

  const GalleryImagePageView({
    Key? key,
    required this.images,
    required this.initialIndex,
  }) : super(key: key);

  @override
  State<GalleryImagePageView> createState() => _GalleryImagePageViewState();
}

class _GalleryImagePageViewState extends State<GalleryImagePageView> {
  late PageController _pageController;
  double _currentIndex = 0;
  final firebaseProvider = locator<FireStorageProvider>();
  final Map<int, String> _imageUrls = {};

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
    _preloadImages();
  }

  Future<void> _preloadImages() async {
    for (int i = 0; i < widget.images.length; i++) {
      if (!_imageUrls.containsKey(i)) {
        final url = await firebaseProvider.getMediaUrl(widget.images[i]);
        _imageUrls[i] = url;
        setState(() {}); // Обновление состояния для перерисовки виджета
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHasPremium = context.select((PaymentProvider e) => e.isHasPremium);

    return ScreenWrap(
      child: SafeArea(
        top: false,
        child: Stack(
          children: [
            Column(
              children: [
                GalleryHeader(
                  currentIndex: _currentIndex,
                  totalLength: widget.images.length,
                  onSave: () async {
                    FirebaseAnaliticsService.logOnSaveI();

                    if (widget.images[_currentIndex.toInt()].mediaData ==
                        null) {
                      return;
                    }
                    if (!isHasPremium) {
                      AppRouter.openPaywall(context, false);
                      return;
                    }

                    await ImageGallerySaver.saveImage(
                      widget.images[_currentIndex.toInt()].mediaData!,
                      quality: 100,
                    );

                    showToast(
                      'Image was saved',
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
                    itemCount: widget.images.length,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: _imageUrls.containsKey(index)
                                  ? BlurWidget(
                                      child: Image.network(
                                        _imageUrls[index]!,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                        errorBuilder: (BuildContext context,
                                            Object error,
                                            StackTrace? stackTrace) {
                                          print('Failed to load image: $error');
                                          return const Center(
                                            child: Text('Failed to load image'),
                                          );
                                        },
                                      ),
                                    )
                                  : const CupertinoActivityIndicator(
                                      color: Colors.white,
                                      radius: 18,
                                    ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
