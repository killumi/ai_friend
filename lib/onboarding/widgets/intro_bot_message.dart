// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IntroBotMessage extends StatelessWidget {
  final String message;

  const IntroBotMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                margin: const EdgeInsets.only(left: 18),
                child: Assets.images.avatar.image(),
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 280,
                  minWidth: 100,
                  minHeight: 50,
                ),
                padding: const EdgeInsets.only(
                    left: 16, right: 10, bottom: 13, top: 13),
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(1.00, -0.03),
                    end: Alignment(-1, 0.03),
                    colors: [Color(0xFF544966), Color(0xFF3F3350)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Color(0xFFFBFBFB),
                    fontSize: 14,
                    fontFamily: FontFamily.gothamPro,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
