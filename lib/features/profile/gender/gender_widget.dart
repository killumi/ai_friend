import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/features/profile/gender/gender_item.dart';
import 'package:ai_friend/features/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenderWidget extends StatefulWidget {
  const GenderWidget({super.key});

  @override
  State<GenderWidget> createState() => _GenderWidgetState();
}

class _GenderWidgetState extends State<GenderWidget> {
  @override
  Widget build(BuildContext context) {
    final profileProvider = context.read<ProfileProvider>();
    final gender = context.select((ProfileProvider e) => e.gender);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Gender',
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
            GenderItem(
              value: 'Male',
              groupValue: gender,
              onChanged: profileProvider.onChangeGender,
            ),
            const SizedBox(width: 16),
            GenderItem(
              value: 'Female',
              groupValue: gender,
              onChanged: profileProvider.onChangeGender,
            ),
            const SizedBox(width: 16),
            GenderItem(
              value: 'Other',
              groupValue: gender,
              onChanged: profileProvider.onChangeGender,
            ),
          ],
        )
      ],
    );
  }
}
