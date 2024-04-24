// ignore_for_file: use_build_context_synchronously

import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/onboarding/onboarding_provider.dart';
import 'package:ai_friend/onboarding/widgets/onboarding_message_item.dart';
import 'package:ai_friend/widgets/app_button.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  Future<void> initOnboarding() async {
    await context.read<OnboardingProvider>().nextStep();
  }

  @override
  void initState() {
    super.initState();
    initOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();
    final messages = provider.messages;
    final listKey = provider.listKey;
    final scrollController = provider.scrollController;

    final isSecondStep = provider.isSecondStep;
    final isFourthStep = provider.isFourthStep;
    final isLastStep = provider.isLastStep;

    return ScreenWrap(
      child: Stack(
        children: [
          SafeArea(
            child: AnimatedList(
              controller: scrollController,
              padding: const EdgeInsets.all(16).copyWith(top: 100, bottom: 100),
              key: listKey,
              initialItemCount: messages.length,
              itemBuilder: (context, index, animation) =>
                  _buildItem(messages[index], animation),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.ease,
            duration: const Duration(milliseconds: 500),
            bottom: isSecondStep ? 50 : -70,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: isSecondStep ? 1 : 0,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 900),
              child: AppButton(
                title: 'Yes',
                onTap: () async {
                  await provider.nextStep();
                  // setState(() {});
                },
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.ease,
            duration: const Duration(milliseconds: 500),
            bottom: isFourthStep ? 50 : -70,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: isFourthStep ? 1 : 0,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 900),
              child: AppButton(
                title: 'Sounds Good!',
                onTap: () async {
                  await provider.nextStep();
                  // setState(() {});
                },
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.ease,
            duration: const Duration(milliseconds: 300),
            bottom: isLastStep ? 50 : -100,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: isLastStep ? 1 : 0,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 300),
              child: AppButton(
                title: 'All Right',
                onTap: () async {
                  await provider.nextStep();
                  AppRouter.openChat(context);
                },
              ),
            ),
          ),
          _buildAppbar(),
        ],
      ),
    );
  }

  Widget _buildAppbar() => Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        decoration: const ShapeDecoration(
          color: Color(0xFF170C22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        child: const SafeArea(
          bottom: false,
          child: Text(
            'AI Girlfriend',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFFBFBFB),
              fontSize: 20,
              fontFamily: FontFamily.gothamPro,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      );
  Widget _buildItem(OnboardingMessage message, Animation<double> animation) {
    final slideTween = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    );

    return SlideTransition(
      position: animation.drive(slideTween),
      child: FadeTransition(
        opacity: animation,
        child: OnboardingMessageItem(message: message),
      ),
    );
  }
}
