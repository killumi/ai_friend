// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:flutter/widgets.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final bool showBackButton;

  const AppHeader({
    Key? key,
    required this.title,
    required this.showBackButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      alignment: Alignment.bottomCenter,
      decoration: const ShapeDecoration(
        color: Color(0xFF170C22),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 72,
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFFBFBFB),
                      fontSize: 20,
                      fontFamily: FontFamily.gothamPro,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 16,
            child: GestureDetector(
              onTap: () => AppRouter.pop(context),
              child: Container(
                width: 28,
                height: 28,
                decoration: const ShapeDecoration(
                  color: Color(0xFF443C4E),
                  shape: OvalBorder(),
                ),
                child: Center(
                  child: Assets.icons.leftChevron.svg(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
