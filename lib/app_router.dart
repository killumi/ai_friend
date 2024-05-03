import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/features/bot_profile/bot_profile_screen.dart';
import 'package:ai_friend/features/bot_profile/bot_short_profile.dart';
import 'package:ai_friend/features/chat/chat_screen.dart';
import 'package:ai_friend/features/gallery/gallery_image/gallery_image_pageview.dart';
import 'package:ai_friend/features/gallery/gallery_screen.dart';
import 'package:ai_friend/features/gallery/gallery_video/gallery_video_pageview.dart';
import 'package:ai_friend/features/onboarding/onboarding_screen.dart';
import 'package:ai_friend/features/onboarding/start_screen.dart';
import 'package:ai_friend/features/payment/payment_screen.dart';
import 'package:ai_friend/features/profile/hobby/profile_hobby_screen.dart';
import 'package:ai_friend/features/profile/profile_info_screen.dart';
import 'package:ai_friend/features/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_route_animator/page_route_animator.dart';

class AppRouter {
  static void pop(BuildContext context) => Navigator.pop(context);

  static void openChat(BuildContext context, {bool removeRoutes = false}) {
    final route = PageRouteAnimator(
      child: const ChatScreen(),
      routeAnimation: RouteAnimation.rightToLeftWithFade,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 600),
    );

    removeRoutes
        ? Navigator.of(context).pushAndRemoveUntil(route, (route) => false)
        : Navigator.push(context, route);
  }

  static void openStart(BuildContext context) {
    final route = CupertinoPageRoute(
      builder: (context) => const StartScreen(),
    );
    Navigator.push(context, route);
  }

  static void openAliceShortProfile(BuildContext context) {
    final route = CupertinoPageRoute(
      builder: (context) => const BotShortProfile(),
    );
    Navigator.push(context, route);
  }

  static void openAliceProfile(BuildContext context) {
    final route = CupertinoPageRoute(
      builder: (context) => const BotProfileScreen(),
    );
    Navigator.push(context, route);
  }

  static void openOnboarding(BuildContext context) {
    final route = PageRouteAnimator(
      child: const OnboardingScreen(),
      routeAnimation: RouteAnimation.bottomToTopWithFade,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 420),
      reverseDuration: const Duration(milliseconds: 420),
    );
    // final route = CupertinoPageRoute(
    //   builder: (context) => const OnboardingScreen(),
    // );

    Navigator.push(context, route);
  }

  static void openHobby(BuildContext context, {bool isEditMod = false}) {
    // final route = PageRouteAnimator(
    //   child: const ProfileHobbyScreen(),
    //   routeAnimation: RouteAnimation.rightToLeftWithFade,
    //   curve: Curves.ease,
    //   duration: const Duration(milliseconds: 600),
    //   reverseDuration: const Duration(milliseconds: 600),
    // );
    final route = CupertinoPageRoute(
      builder: (context) => ProfileHobbyScreen(isEditMod: isEditMod),
    );

    Navigator.push(context, route);
  }

  static void openProfile(BuildContext context, {bool isEditMod = false}) {
    // final route = PageRouteAnimator(
    //   child: const ProfileInfoScreen(),
    //   routeAnimation: RouteAnimation.bottomToTopWithFade,
    //   curve: Curves.ease,
    //   duration: const Duration(milliseconds: 420),
    //   reverseDuration: const Duration(milliseconds: 420),
    // );
    final route = CupertinoPageRoute(
      builder: (context) => ProfileInfoScreen(isEditMod: isEditMod),
    );
    Navigator.push(context, route);
  }

  static void openGallery(BuildContext context) {
    final route = CupertinoPageRoute(
      builder: (context) => const GalleryScreen(),
    );
    Navigator.push(context, route);
  }

  static void openSettings(BuildContext context) {
    final route = CupertinoPageRoute(
      builder: (context) => const SettingsScreen(),
    );
    Navigator.push(context, route);
  }

  static void openGalleryVideoPageView(
    BuildContext context,
    List<IChatMessage> videos,
    int initIndex,
  ) {
    final route = CupertinoPageRoute(
      builder: (context) => GalleryVideoPageView(
        videos: videos,
        initialIndex: initIndex,
      ),
    );
    Navigator.push(context, route);
  }

  static void openGalleryImagePageView(
    BuildContext context,
    List<IChatMessage> images,
    int initIndex,
  ) {
    final route = CupertinoPageRoute(
      builder: (context) => GalleryImagePageView(
        images: images,
        initialIndex: initIndex,
      ),
    );
    Navigator.push(context, route);
  }

  static void openPaywall(BuildContext context, bool removeRoutes) {
    removeRoutes
        ? Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (context) => const PaymentScreen()),
            (route) => false)
        : Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => const PaymentScreen()));
  }
}
