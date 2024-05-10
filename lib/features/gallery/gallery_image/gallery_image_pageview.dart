// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/widgets/blur_widget.dart';
import 'package:ai_friend/widgets/gallery_save_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';
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

  @override
  Widget build(BuildContext context) {
    final isHasPremium = context.select((PaymentProvider e) => e.isHasPremium);
    final isSmal = MediaQuery.of(context).size.height < 750;

    return ScreenWrap(
      child: SafeArea(
        top: false,
        child: Stack(
          children: [
            Column(
              children: [
                buildHeader(isHasPremium, isSmal),
                Expanded(
                  child: PageView.builder(
                    itemCount: widget.images.length,
                    controller: _pageController,
                    onPageChanged: (e) {
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: BlurWidget(
                                child: Image.memory(
                                    widget.images[index].mediaData!),
                              ),
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

  Widget buildHeader(bool isSmal, bool isHasPremium) => Container(
        width: double.infinity,
        height: isSmal ? 90 : 120,
        alignment: Alignment.bottomCenter,
        decoration: const ShapeDecoration(
          color: Color(0xFF170C22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        child: Stack(
          // clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 72,
                  child: Center(
                    child: Text(
                      '${_currentIndex.toInt() + 1} of ${widget.images.length}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFFBFBFB),
                        fontSize: 20,
                        fontFamily: FontFamily.gothamPro,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 16,
              child: GestureDetector(
                onTap: () => AppRouter.pop(context),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF443C4E),
                    shape: OvalBorder(),
                  ),
                  child: Center(
                    child: Assets.icons.leftChevron.svg(),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 16,
              child: GallerySaveButton(
                onTap: () async {
                  if (widget.images[_currentIndex.toInt()].mediaData == null) {
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
            ),
          ],
        ),
      );
}
