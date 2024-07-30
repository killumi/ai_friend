import 'package:ai_friend/domain/services/app_router.dart';
import 'package:ai_friend/domain/services/locator.dart';
import 'package:ai_friend/features/assistants/assistant_item.dart';
import 'package:ai_friend/features/assistants/assistant_storage.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/widgets/app_header.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AssistantListScreen extends StatefulWidget {
  const AssistantListScreen({super.key});

  @override
  State<AssistantListScreen> createState() => _AssistantListScreenState();
}

class _AssistantListScreenState extends State<AssistantListScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenWrap(
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            AppHeader(
              title: 'Chats',
              showBackButton: false,
              leading: SizedBox(
                width: 96,
                height: 40,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => AppRouter.openSettings(context),
                    child: Container(
                      height: 40,
                      width: 40,
                      color: Colors.transparent,
                      alignment: Alignment.centerLeft,
                      child: Assets.icons.settingsIcon.svg(),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: locator<AssistantStorage>().box.listenable(),
                builder: (context, box, widget) {
                  final assistants = locator<AssistantStorage>().profiles;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16)
                        .copyWith(top: 50),
                    itemBuilder: (context, index) =>
                        AssistantItem(assistant: assistants[index]),
                    itemCount: assistants.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
