// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IntroUserMessage extends StatelessWidget {
  final String message;

  const IntroUserMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 220,
          minWidth: 80,
          minHeight: 50,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        clipBehavior: Clip.antiAlias,
        decoration: const ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.71, 0.71),
            end: Alignment(0.71, -0.71),
            colors: [Color(0xFFBB3DA0), Color(0xFFA762EA)],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message,
              style: const TextStyle(
                color: Color(0xFFFBFBFB),
                fontSize: 14,
                fontFamily: FontFamily.sFPro,
                fontWeight: FontWeight.w400,
                height: 0.10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
