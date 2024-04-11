import 'package:ai_friend/gpt/chat_script/chat_script_provider.dart';
import 'package:ai_friend/gpt/chat_script/widgets/script_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScriptBox extends StatelessWidget {
  const ScriptBox({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatScriptProvider>();
    final day = provider.currentDayNumber;
    final message = provider.currentMessageNumber + 1;

    return provider.dailyScript == null
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
        : GestureDetector(
            onTap: () {
              provider.showCurrent();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              decoration: BoxDecoration(
                  color: Colors.cyan, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.white,
                    child: Text(
                      'DAY: $day - MESSAGE:$message',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Text(
                    provider.scriptMessage!.description,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  ...provider.scriptMessage!.messages
                      .map((e) => ScriptMessage(data: e))
                      .toList(),
                ],
              ),
            ),
          );
  }
}
