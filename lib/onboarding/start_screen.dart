import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/widgets/app_button.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenWrap(
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 100),
              child: Assets.images.startScreen.image(width: double.infinity),
            ),
            Column(
              children: [
                const SizedBox(height: 47),
                const Text(
                  'AI Girlfriend:\nFriendly Chat',
                  style: TextStyle(
                    color: Color(0xFFFBFBFB),
                    fontSize: 32,
                    fontFamily: 'Gotham Pro',
                    fontWeight: FontWeight.w900,
                    height: 0,
                  ),
                ),
                const Spacer(),
                const Text(
                  'The AI Girlfriend who\nis always here for you',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFBFBFB),
                    fontSize: 20,
                    fontFamily: FontFamily.gothamPro,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppButton(
                    onTap: () => AppRouter.openOnboarding(context),
                    title: 'Start Chat',
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'By signing up, you agree to our \n',
                              style: TextStyle(
                                color: Color(0xFFFBFBFB),
                                fontSize: 14,
                                fontFamily: FontFamily.gothamPro,
                                fontWeight: FontWeight.w400,
                                height: 4,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: FontFamily.sFPro,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                // height: 0.12,
                              ),
                            ),
                            TextSpan(
                              text: ' and ',
                              style: TextStyle(
                                color: Color(0xFFFBFBFB),
                                fontSize: 14,
                                fontFamily: FontFamily.gothamPro,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: Color(0xFFFBFBFB),
                                fontSize: 14,
                                fontFamily: FontFamily.sFPro,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            )
          ],
        ),
      ),
    );
  }
}
