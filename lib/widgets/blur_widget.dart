// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/widgets/app_button.dart';

class BlurWidget extends StatelessWidget {
  final bool? showButton;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapBlur;
  final Widget? child;
  final StackFit? fit;

  const BlurWidget({
    Key? key,
    this.showButton = true,
    this.onTap,
    this.onTapBlur,
    this.child,
    this.fit = StackFit.loose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isHasPremium = context.select((PaymentProvider e) => e.isHasPremium);

    return ClipRRect(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          fit: fit!,
          children: [
            if (child != null) child!,
            if (!isHasPremium)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.55),
                ),
              ),
            if (!isHasPremium)
              Positioned.fill(
                child: GestureDetector(
                  onTap: onTapBlur == null
                      ? () => AppRouter.openPaywall(context, false)
                      : () => onTapBlur!(),
                  child: Opacity(
                    opacity: 0.88,
                    child: Assets.images.blur.image(fit: BoxFit.cover),
                  ),
                ),
              ),
            if (showButton! && !isHasPremium)
              SizedBox(
                height: 40,
                width: 120,
                child: AppButton(
                  title: 'Unblur',
                  icon: Assets.icons.proIcon.svg(width: 23),
                  onTap: onTapBlur == null
                      ? () => AppRouter.openPaywall(context, false)
                      : () => onTapBlur!(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
