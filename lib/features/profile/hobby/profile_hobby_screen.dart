// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/features/profile/hobby/hobby_item.dart';
import 'package:ai_friend/features/profile/hobby/hobby_provider.dart';
import 'package:ai_friend/features/profile/hobby/hobby_storage.dart';
import 'package:ai_friend/widgets/app_button.dart';
import 'package:ai_friend/widgets/app_header.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';

class ProfileHobbyScreen extends StatefulWidget {
  final bool? isEditMod;

  const ProfileHobbyScreen({
    Key? key,
    this.isEditMod = false,
  }) : super(key: key);

  @override
  State<ProfileHobbyScreen> createState() => _ProfileHobbyScreenState();
}

class _ProfileHobbyScreenState extends State<ProfileHobbyScreen> {
  String get title => widget.isEditMod! ? 'Done' : 'Continue';
  String get appBarTitle =>
      widget.isEditMod! ? 'Edit interests' : 'Your interests';

  bool get isEditMod => widget.isEditMod!;

  @override
  Widget build(BuildContext context) {
    final hobbyProvider = context.read<HobbyProvider>();
    final hobbies = context.select((HobbyProvider e) => e.hobby);

    return ScreenWrap(
      resizeToAvoidBottomInset: true,
      child: Stack(
        children: [
          Column(
            children: [
              _buildAppbar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(top: 20),
                  child: ValueListenableBuilder(
                    valueListenable: HobbyStorage().storage.listenable(),
                    builder: (context, box, widget) {
                      final selected = box.values.toList();

                      return Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        runSpacing: 10,
                        children: hobbies
                            .map(
                              (e) => HobbyItem(
                                value: e,
                                isSelected: selected.contains(e.toString()),
                                onChanged: hobbyProvider.toggleSelect,
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ValueListenableBuilder(
                    valueListenable: HobbyStorage().storage.listenable(),
                    builder: (context, box, widget) {
                      final selected = box.values.toList();

                      return AppButton(
                        title: title,
                        onTap: () async {
                          if (isEditMod) {
                            AppRouter.pop(context);
                            return;
                          }
                          AppRouter.openChat(context);
                        },
                        isDisabled: selected.isEmpty,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppbar() => AppHeader(title: appBarTitle, showBackButton: true);
}
