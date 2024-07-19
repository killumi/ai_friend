// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:ai_friend/features/profile/hobby/hobby_helper.dart';
import 'package:ai_friend/features/profile/hobby/hobby_item.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/widgets/app_button.dart';
import 'package:ai_friend/widgets/app_header.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:pro_animated_blur/pro_animated_blur.dart';
import 'package:provider/provider.dart';

class BotProfileScreen extends StatefulWidget {
  const BotProfileScreen({super.key});

  @override
  State<BotProfileScreen> createState() => _BotProfileScreenState();
}

class _BotProfileScreenState extends State<BotProfileScreen> {
  late PageController _pageController;
  double _currentIndex = 0;

  final List<ImageProvider> _imagePaths = [
    Assets.alicePhotos.img1.provider(),
    Assets.alicePhotos.img2.provider(),
    Assets.alicePhotos.img3.provider(),
    Assets.alicePhotos.img4.provider(),
  ];

  final List<HOBBY> aliceHobby = [
    HOBBY.height,
    HOBBY.music,
    HOBBY.literature,
    HOBBY.technology,
    HOBBY.friendly,
    HOBBY.artDesign,
    HOBBY.intellectual,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex.toInt());
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
    if (_currentIndex == _imagePaths.length - 1) {
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

    return ScreenWrap(
      resizeToAvoidBottomInset: true,
      child: Stack(
        children: [
          Column(
            children: [
              _buildAppbar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: next,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: AspectRatio(
                                  aspectRatio: 0.85 / 1,
                                  child: PageView.builder(
                                    itemCount: _imagePaths.length,
                                    controller: _pageController,
                                    // physics:
                                    //     const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return BotProfileImage(
                                        isBlured: index != 0 && !isHasPremium,
                                        data: _imagePaths[index],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            // Positioned.fill(
                            //     child: Row(
                            //   children: [
                            //     Expanded(
                            //       child: GestureDetector(
                            //         onTap: next,
                            //         child: Container(
                            //           color: Colors.transparent,
                            //         ),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: GestureDetector(
                            //         child: Container(
                            //           color: Colors.transparent,
                            //         ),
                            //       ),
                            //     )
                            //   ],
                            // )),
                            Positioned(
                              top: 10,
                              right: 0,
                              left: 0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  children: [1, 2, 3, 4].map(
                                    (e) {
                                      final isSelected = e == _currentIndex + 1;
                                      return Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 4,
                                          decoration: BoxDecoration(
                                              color: isSelected
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            const Text(
                              'Alice, 25 y.o.',
                              style: TextStyle(
                                color: Color(0xFFFBFBFB),
                                fontSize: 24,
                                fontFamily: FontFamily.gothamPro,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              // "Hi, handsome! I'm your virtual muse, Alice.\nLet's forget about everything and dive into the world of our fiery conversation right now!",
                              "Hi, handsome! I'm your virtual muse, Alice.\nLet's forget about everything and dive into the world of our conversation right now!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: FontFamily.sFPro,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 12),
                            IgnorePointer(
                              ignoring: true,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 4,
                                runSpacing: 4,
                                children: aliceHobby
                                    .map(
                                      (e) => HobbyItem(
                                        value: e,
                                        isEditMod: true,
                                        isSelected: true,
                                        onChanged: (e) {},
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppbar() =>
      const AppHeader(title: 'Profile', showBackButton: true);
}

class BotProfileImage extends StatelessWidget {
  final ImageProvider data;
  final bool isBlured;
  const BotProfileImage({required this.data, this.isBlured = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(image: data, fit: BoxFit.cover),
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black12,
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            ignoring: !isBlured,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: isBlured ? 15 : 0,
                sigmaY: isBlured ? 15 : 0,
              ),
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: isBlured ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.ease,
                  child: SizedBox(
                    height: 40,
                    width: 120,
                    child: AppButton(
                      title: 'Unblur',
                      icon: Assets.icons.proIcon.svg(width: 23),
                      onTap: () => AppRouter.openPaywall(context, false),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
