import 'package:ai_friend/domain/services/app_router.dart';
import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/widgets/app_button.dart';
import 'package:flutter/material.dart';

class ContinueChatWidget extends StatelessWidget {
  final String title;
  const ContinueChatWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final isSmal = MediaQuery.of(context).size.height < 750;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
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
            onTap: () {
              // locator<PaymentProvider>().setFreePremium();
              FirebaseAnaliticsService.logOnTapContinueChatingButton();
              AppRouter.openPaywall(context, false);
            },
          ),
        ),
        if (isSmal) const SizedBox(height: 20),
      ],
    );
  }
}
