import 'package:ai_friend/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContinueChatWidget extends StatelessWidget {
  const ContinueChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ChatScriptProvider>();

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            'Alice will be online in 12 hours. You can get a PRO and continue chatting with her right away',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xB2FBFBFB),
              fontSize: 12,
              fontFamily: FontFamily.sFPro,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 48,
          width: 210,
          child: AppButton(
            title: 'Continue chatting',
            icon: Assets.icons.proIcon.svg(width: 23),
            onTap: () => provider.showNextMessage(),
          ),
        ),
      ],
    );
  }
}
