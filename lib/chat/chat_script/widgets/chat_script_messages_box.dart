import 'package:ai_friend/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/chat/chat_script/widgets/chat_script_message.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScriptMessagesBox extends StatelessWidget {
  const ChatScriptMessagesBox({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatScriptProvider>();
    // final day = provider.currentDayNumber;
    // final message = provider.currentMessageNumber + 1;

    return provider.dailyScript == null
        // ? const SizedBox(height: 1)
        ? Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                'Это пока весь сценарий, нажмитe "<Day" - чтоб вернуться на предыдущий день ИЛИ "Restart" - чтоб вернуться на 1 день 1 сообщение',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        : Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.71, 0.71),
                      end: Alignment(0.71, -0.71),
                      colors: [Color(0xFFBB3DA0), Color(0xFFA762EA)],
                    ),
                    shape: OvalBorder(),
                  ),
                  child: Center(child: Assets.icons.lightbulb.svg()),
                ),
                const SizedBox(height: 12),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                  child: Text(
                    provider.scriptMessage!.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFFBFBFB),
                      fontSize: 16,
                      fontFamily: FontFamily.gothamPro,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                  child: Column(children: [
                    const SizedBox(height: 20),
                    ...provider.scriptMessage!.messages
                        .map((e) => ChatScriptMessage(data: e))
                        .toList(),
                  ]),
                ),
              ],
            ),
          );
  }
}
