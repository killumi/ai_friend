// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:ai_enhancer/gen/assets.gen.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ai_friend/domain/services/app_router.dart';
import 'package:ai_friend/features/profile/hobby/hobby_helper.dart';
import 'package:ai_friend/gen/fonts.gen.dart';

class HobbyItem extends StatelessWidget {
  final HOBBY value;
  final bool isSelected;
  final bool? isEditMod;
  final ValueChanged<HOBBY> onChanged;

  const HobbyItem({
    Key? key,
    required this.value,
    required this.isSelected,
    this.isEditMod = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      tilt: false,
      onTap: () {
        if (isEditMod!) {
          AppRouter.openHobby(context, isEditMod: true);
          return;
        }
        HapticFeedback.mediumImpact();
        onChanged(value);
      },
      child: Container(
        height: isEditMod! ? 35 : 50,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: isEditMod! ? const Color(0xB2340541) : null,
          gradient: isSelected
              ? isEditMod!
                  ? null
                  : const LinearGradient(
                      begin: Alignment(-0.71, 0.71),
                      end: Alignment(0.71, -0.71),
                      colors: [Color(0xFFBB3DA0), Color(0xFFA762EA)],
                    )
              : isEditMod!
                  ? null
                  : LinearGradient(
                      begin: const Alignment(1.00, -0.03),
                      end: const Alignment(-1, 0.03),
                      colors: [
                        Colors.white.withOpacity(0.10000000149011612),
                        Colors.white.withOpacity(0.15000000596046448)
                      ],
                    ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            value.getHobbyIcon(),
            const SizedBox(width: 8),
            Text(
              value.getHobbyTitle(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: FontFamily.gothamPro,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FakeHobbyItem extends StatelessWidget {
  final String title;
  final Image icon;

  const FakeHobbyItem({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xB2340541),
        // gradient: const LinearGradient(
        //   begin: Alignment(-0.71, 0.71),
        //   end: Alignment(0.71, -0.71),
        //   colors: [Color(0xFFBB3DA0), Color(0xFFA762EA)],
        // ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: FontFamily.gothamPro,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
