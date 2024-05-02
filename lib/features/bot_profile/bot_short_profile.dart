// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/widgets/app_button.dart';
import 'package:ai_friend/widgets/app_header.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro_animated_blur/pro_animated_blur.dart';

class BotShortProfile extends StatefulWidget {
  const BotShortProfile({super.key});

  @override
  State<BotShortProfile> createState() => _BotShortProfileState();
}

class _BotShortProfileState extends State<BotShortProfile> {
  late PageController _pageController;
  double _currentIndex = 0;

  final List<ImageProvider> _imagePaths = [
    Assets.alicePhotos.img1.provider(),
    Assets.alicePhotos.img2.provider(),
    Assets.alicePhotos.img3.provider(),
    Assets.alicePhotos.img4.provider(),
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
                                  aspectRatio: 0.7 / 1,
                                  child: PageView.builder(
                                    itemCount: _imagePaths.length,
                                    controller: _pageController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return SettingsCarouselItem(
                                        isBlured: index != 0,
                                        data: _imagePaths[index],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
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
                        const SizedBox(height: 40),
                        AppButton(title: 'Chat Now', onTap: () {}),
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

class SettingsCarouselItem extends StatelessWidget {
  final ImageProvider data;
  final bool isBlured;
  const SettingsCarouselItem(
      {required this.data, this.isBlured = true, super.key});

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
          child: IgnorePointer(
            ignoring: !isBlured,
            child: ProAnimatedBlur(
              blur: isBlured ? 15 : 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
              child: Container(
                color: Colors.transparent,
                child: Center(
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
                        onTap: () {
                          print('object vl');
                        },
                      ),
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
