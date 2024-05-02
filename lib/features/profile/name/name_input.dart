import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/features/profile/profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NameInput extends StatelessWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.read<ProfileProvider>();
    final controller =
        context.select((ProfileProvider e) => e.nameTextController);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Name',
          style: TextStyle(
            fontFamily: FontFamily.gothamPro,
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 56,
                child: CupertinoTextField(
                  controller: controller,
                  onChanged: profileProvider.onChangeName,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xff3E2F53),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xff88848B),
                    ),
                  ),
                  placeholder: 'Name...',
                  placeholderStyle: const TextStyle(
                    color: Color(0xFFBDBBBF),
                    fontSize: 14,
                    fontFamily: FontFamily.gothamPro,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                  style: const TextStyle(
                    color: Color(0xFFFBFBFB),
                    fontSize: 14,
                    fontFamily: FontFamily.gothamPro,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
