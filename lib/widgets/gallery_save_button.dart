// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bounce/bounce.dart';
import 'package:flutter/cupertino.dart';

import 'package:ai_friend/gen/fonts.gen.dart';

class GallerySaveButton extends StatelessWidget {
  final GestureTapCallback onTap;

  const GallerySaveButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      tilt: false,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color(0xffA762EA),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Row(
          children: [
            Text(
              'Save',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xffA762EA),
                fontFamily: FontFamily.gothamPro,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 10),
            Icon(
              CupertinoIcons.cloud_download,
              color: Color(0xffA762EA),
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
