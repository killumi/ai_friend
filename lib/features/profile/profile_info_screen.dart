// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_friend/features/profile/widgets/profile_edit_hobby.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:ai_friend/app_router.dart';
// import 'package:ai_friend/features/profile/birthdate/birthdate_widget.dart';
import 'package:ai_friend/features/profile/gender/gender_widget.dart';
import 'package:ai_friend/features/profile/name/name_input.dart';
import 'package:ai_friend/features/profile/profile_provider.dart';
import 'package:ai_friend/widgets/app_button.dart';
import 'package:ai_friend/widgets/app_header.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';

class ProfileInfoScreen extends StatefulWidget {
  final bool? isEditMod;
  const ProfileInfoScreen({
    Key? key,
    this.isEditMod = false,
  }) : super(key: key);

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final profileProvider = context.read<ProfileProvider>();
    final isDisabled = context.select((ProfileProvider e) => e.isDisabled);
    final isSmal = MediaQuery.of(context).size.height < 750;

    return ScreenWrap(
      resizeToAvoidBottomInset: true,
      child: Stack(
        children: [
          Column(
            children: [
              _buildAppbar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const NameInput(),
                      const SizedBox(height: 28),
                      const GenderWidget(),
                      // const SizedBox(height: 28),
                      // const BirthDateWidget(),
                      if (widget.isEditMod!) const ProfileEditHobby(),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppButton(
                    title: widget.isEditMod! ? 'Save' : 'Continue',
                    onTap: () async {
                      profileProvider.onSaveProfile();
                      if (widget.isEditMod!) {
                        AppRouter.pop(context);
                        return;
                      }
                      AppRouter.openHobby(context);
                    },
                    isDisabled: isDisabled,
                  ),
                ),
              ),
              isSmal ? const SizedBox(height: 20) : const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppbar() =>
      const AppHeader(title: 'Profile Information', showBackButton: true);
}
