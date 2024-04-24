import 'package:ai_friend/chat/chat_screen.dart';
import 'package:ai_friend/gallery/gallery_screen.dart';
import 'package:ai_friend/onboarding/onboarding_screen.dart';
import 'package:ai_friend/onboarding/start_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRouter {
  void pop(BuildContext context) => Navigator.pop(context);

  static void openChat(BuildContext context) {
    final route = CupertinoPageRoute(
      builder: (context) => const ChatScreen(),
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
    final route = CupertinoPageRoute(
      builder: (context) => const OnboardingScreen(),
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
}
