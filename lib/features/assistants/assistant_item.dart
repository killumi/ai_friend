// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_friend/domain/services/app_router.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/widgets/assistant_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_friend/domain/entity/i_assistant/i_assistant.dart';
import 'package:ai_friend/features/assistants/assistants_provider.dart';
import 'package:ai_friend/features/chat/chat_provider.dart';

class AssistantItem extends StatelessWidget {
  final IAssistant assistant;
  const AssistantItem({
    Key? key,
    required this.assistant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AssistantsProvider>();
    final isLoading = context.select((ChatProvider e) => e.isLoading);
    final currentAssistant = provider.currentAssistant;

    return GestureDetector(
      onTap: () async {
        final provider = context.read<AssistantsProvider>();
        provider.selectAssistant(assistant);
        await context.read<ChatScriptProvider>().initScript().then((e) {
          AppRouter.openChat(context);
        });
      },
      child: Container(
        height: 60,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: Colors.white10,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AssistantAvatar(assistant: assistant),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        assistant.name,
                        style: const TextStyle(
                          color: Color(0xFFFBFBFB),
                          fontSize: 16,
                          fontFamily: FontFamily.gothamPro,
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      const Spacer(),
                      if (assistant.messages!.isNotEmpty)
                        Text(
                          assistant.getDate(assistant.messages!.last),
                          style: const TextStyle(
                            color: Color(0xFFFBFBFB),
                            fontSize: 12,
                            fontFamily: FontFamily.gothamPro,
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (assistant.messages!.isNotEmpty)
                    Row(
                      children: [
                        assistant.messages!.last.isText
                            ? Expanded(
                                child: Text(
                                  assistant.id == currentAssistant?.id &&
                                          isLoading
                                      ? 'Typing...'
                                      : assistant.messages!.last.content,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color(0xFFFBFBFB),
                                    fontSize: 14,
                                    fontFamily: FontFamily.gothamPro,
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (assistant.messages!.last.isImage)
                                    const Icon(
                                      CupertinoIcons
                                          .photo_fill_on_rectangle_fill,
                                      color: Colors.white,
                                    ),
                                  if (assistant.messages!.last.isImage)
                                    const Text(
                                      ' Image',
                                      style: TextStyle(
                                        fontFamily: FontFamily.gothamPro,
                                        color: Colors.white,
                                        fontSize: 14,
                                        height: 0,
                                      ),
                                    ),
                                  if (assistant.messages!.last.isVideo)
                                    const Icon(
                                      CupertinoIcons.video_camera_solid,
                                      color: Colors.white,
                                    ),
                                  if (assistant.messages!.last.isVideo)
                                    const Text(
                                      ' Video',
                                      style: TextStyle(
                                        fontFamily: FontFamily.gothamPro,
                                        color: Colors.white,
                                        fontSize: 14,
                                        height: 0,
                                      ),
                                    ),
                                ],
                              ),
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
