// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/domain/helpers/rate_app_helper.dart';
import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/widgets/app_header.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isHasPremium) const SizedBox(height: 20),
                      if (!isHasPremium)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () =>
                                  AppRouter.openPaywall(context, false),
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Assets.images.settingsAvatar
                                      .image(width: 110),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: 121,
                                      height: 30,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFF54BCF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        shadows: const [
                                          BoxShadow(
                                            color: Color(0x7FF54BCF),
                                            blurRadius: 15,
                                            offset: Offset(0, 0),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Subscribe',
                                          style: TextStyle(
                                            color: Color(0xFFFBFBFB),
                                            fontSize: 12,
                                            fontFamily: FontFamily.gothamPro,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    AppRouter.openPaywall(context, false),
                                child: Container(
                                  height: 80,
                                  padding: const EdgeInsets.only(
                                    left: 30,
                                    top: 14,
                                    right: 0,
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Assets.images.settingsPopup
                                          .provider(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: const Text(
                                    'Upgrade to PRO and get\na deeper connection with me!',
                                    style: TextStyle(
                                      color: Color(0xFFFBFBFB),
                                      fontSize: 11,
                                      fontFamily: FontFamily.gothamPro,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 20),
                      SettingsItem(
                        title: 'Your Profile',
                        icon: Assets.icons.profileIcon.svg(),
                        onTap: () =>
                            AppRouter.openProfile(context, isEditMod: true),
                      ),
                      SettingsItem(
                        title: 'Rate us',
                        icon: Assets.icons.rateIcon.svg(),
                        onTap: () => RateAppHelper.showDialog(context),
                      ),
                      SettingsItem(
                        title: 'Share the app',
                        icon: Assets.icons.shareIcon.svg(),
                        onTap: () => Share.share('text'),
                      ),
                      SettingsItem(
                        title: 'Give feedback',
                        icon: Assets.icons.feedbackIcon.svg(),
                        onTap: () {
                          launchUrl(
                            Uri.parse('https://forms.gle/1AoHvPv34pgxdQLVA'),
                          );
                        },
                      ),
                    ],
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
      const AppHeader(title: 'Settings', showBackButton: true);
}

class SettingsItem extends StatelessWidget {
  final String title;
  final SvgPicture icon;
  final GestureTapCallback onTap;

  const SettingsItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap,
      tilt: false,
      child: Container(
        width: double.infinity,
        height: 62,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.only(bottom: 12),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: const Alignment(1.00, -0.03),
            end: const Alignment(-1, 0.03),
            colors: [
              Colors.white.withOpacity(0.10000000149011612),
              Colors.white.withOpacity(0.15000000596046448)
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: FontFamily.gothamPro,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
