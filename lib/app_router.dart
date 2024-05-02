import 'package:ai_friend/features/chat/chat_screen.dart';
import 'package:ai_friend/features/gallery/gallery_screen.dart';
import 'package:ai_friend/features/onboarding/onboarding_screen.dart';
import 'package:ai_friend/features/onboarding/start_screen.dart';
import 'package:ai_friend/features/profile/hobby/profile_hobby_screen.dart';
import 'package:ai_friend/features/profile/profile_info_screen.dart';
import 'package:ai_friend/features/settings/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_route_animator/page_route_animator.dart';

class AppRouter {
  static void pop(BuildContext context) => Navigator.pop(context);

  static void openChat(BuildContext context) {
    final route = PageRouteAnimator(
      child: const ChatScreen(),
      routeAnimation: RouteAnimation.rightToLeftWithFade,
      curve: Curves.ease,
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 600),
    );

    Navigator.push(context, route);
  }

  static void openStart(BuildContext context) {
    final route = CupertinoPageRoute(
      builder: (context) => const StartScreen(),
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

  static void openPaywall(BuildContext context) {
    final route = CupertinoPageRoute(
      builder: (context) => const ChatScreen(),
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
}
