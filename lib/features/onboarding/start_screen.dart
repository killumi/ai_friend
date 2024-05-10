import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/widgets/pulse_button.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmal = MediaQuery.of(context).size.height < 750;
    // print('isSmal: $isSmal');
    // print('isSmal: ${MediaQuery.of(context).size.height}');

    return ScreenWrap(
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            isSmal
                ? Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.topCenter,
                      margin: const EdgeInsets.only(bottom: 100),
                      child:
                          Assets.images.startScreen.image(fit: BoxFit.fitWidth),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 100),
                    child:
                        Assets.images.startScreen.image(width: double.infinity),
                  ),
            Column(
              children: [
                SizedBox(height: isSmal ? 10 : 47),
                Text(
                  'AI Girlfriend:\nFriendly Chat',
                  style: TextStyle(
                    color: const Color(0xFFFBFBFB),
                    fontSize: isSmal ? 27 : 32,
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
                  child: PulseButton(
                    onTap: () => AppRouter.openOnboarding(context),
                    title: 'Start Chat',
                  ),
                ),
                SizedBox(height: isSmal ? 30 : 42),
                const Text(
                  'By signing up, you agree to our \n',
                  style: TextStyle(
                    color: Color(0xFFFBFBFB),
                    fontSize: 14,
                    fontFamily: FontFamily.gothamPro,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        launchUrl(
                          Uri.parse(
                              'https://doc-hosting.flycricket.io/ai-girlfriend-friendly-chat-terms-of-use/47ace2aa-8536-4d16-9f8c-01af0a7717e2/terms'),
                        );
                      },
                      child: const Text(
                        'Terms of Service',
                        style: TextStyle(
                          color: Color(0xFFFBFBFB),
                          fontSize: 14,
                          fontFamily: FontFamily.sFPro,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          height: 0,
                        ),
                      ),
                    ),
                    const Text(
                      ' and ',
                      style: TextStyle(
                        color: Color(0xFFFBFBFB),
                        fontSize: 14,
                        fontFamily: FontFamily.gothamPro,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(
                          Uri.parse(
                              'https://doc-hosting.flycricket.io/ai-girlfriend-friendly-chat-privacy-policy/98d20278-4947-48cb-9493-09ebeec0e9e7/privacy'),
                        );
                      },
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: Color(0xFFFBFBFB),
                          fontSize: 14,
                          fontFamily: FontFamily.sFPro,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          height: 0,
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
