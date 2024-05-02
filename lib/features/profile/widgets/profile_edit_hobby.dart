import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/features/profile/hobby/hobby_helper.dart';
import 'package:ai_friend/features/profile/hobby/hobby_item.dart';
import 'package:ai_friend/features/profile/hobby/hobby_storage.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileEditHobby extends StatelessWidget {
  const ProfileEditHobby({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Your Interests',
              style: TextStyle(
                color: Color(0xFFFBFBFB),
                fontSize: 16,
                fontFamily: FontFamily.gothamPro,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            GestureDetector(
              onTap: () => AppRouter.openHobby(context, isEditMod: true),
              child: Container(
                color: Colors.transparent,
                width: 100,
                alignment: Alignment.centerRight,
                child: const Text(
                  'Edit',
                  style: TextStyle(
                    color: Color(0xFFA762EA),
                    fontSize: 16,
                    fontFamily: FontFamily.gothamPro,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        ValueListenableBuilder(
          valueListenable: HobbyStorage().storage.listenable(),
          builder: (context, box, widget) {
            final selected = box.values.toList();

            return Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: selected
                  .map(
                    (e) => HobbyItem(
                      value: e.getHobby(),
                      isEditMod: true,
                      isSelected: selected.contains(e.toString()),
                      onChanged: (e) {},
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
