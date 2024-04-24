// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_friend/onboarding/widgets/intro_bot_message.dart';
import 'package:ai_friend/onboarding/widgets/intro_user_message.dart';
import 'package:ai_friend/onboarding/widgets/intro_video_message.dart';
import 'package:flutter/cupertino.dart';

import 'package:ai_friend/onboarding/onboarding_provider.dart';

class OnboardingMessageItem extends StatelessWidget {
  final OnboardingMessage message;

  const OnboardingMessageItem({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          message.isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        _buildMessage(),
      ],
    );
  }

  Widget _buildMessage() {
    if (message.text != null) return _buildTextMessage();
    if (message.videoAsset != null) return _buildVideoMessage();
    return const SizedBox();
  }

  Widget _buildTextMessage() {
    return message.isBot
        ? IntroBotMessage(message: message.text!)
        : IntroUserMessage(message: message.text!);
  }

  Widget _buildVideoMessage() {
    return IntroVideoMessage(message: message);
  }
}
