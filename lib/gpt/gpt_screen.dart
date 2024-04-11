import 'package:ai_friend/gpt/chat_script/chat_script_provider.dart';
import 'package:ai_friend/gpt/chat_script/widgets/script_box.dart';
import 'package:ai_friend/gpt/gpt_provider.dart';
import 'package:ai_friend/gpt/widgets/message_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GptScreen extends StatefulWidget {
  const GptScreen({super.key});

  @override
  State<GptScreen> createState() => _GptScreenState();
}

class _GptScreenState extends State<GptScreen> {
  final FocusNode _node = FocusNode();
  bool showMessages = true;

  @override
  void initState() {
    _node.addListener(() {
      if (_node.hasFocus) {
        showMessages = false;
        setState(() {});
      } else {
        showMessages = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gptProvider = context.watch<GPTProvider>();
    final scriptProvider = context.read<ChatScriptProvider>();
    final needSendToScriptBot =
        context.select((ChatScriptProvider e) => e.needSendToScriptBot);
    final textAvailable =
        context.select((ChatScriptProvider e) => e.textfieldAvailable);
    final unlockTextField =
        context.select((ChatScriptProvider e) => e.unlockTextField);

    final textfieldAvailable = unlockTextField || textAvailable;
    final messages = gptProvider.messages;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff2A2D3E),
      appBar: AppBar(
        backgroundColor: const Color(0xff2A2D3E),
        title: const Text(
          'Bot Chat',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: gptProvider.scrollController,
                itemBuilder: (context, index) {
                  return MessageItem(message: messages[index]);
                },
                itemCount: messages.length,
              ),
            ),
            const ScriptBox(),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: CupertinoTextField(
                            focusNode: _node,
                            controller: gptProvider.textController,
                            suffix: Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: textfieldAvailable
                                  ? const Icon(
                                      CupertinoIcons.lock_open_fill,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      CupertinoIcons.lock_fill,
                                      color: Colors.black,
                                    ),
                            ),
                            onTap: () {
                              if (!textfieldAvailable) {
                                _node.unfocus();
                                final snackBar = SnackBar(
                                  content: const Text(
                                      'В сценарии в этом месте нет "Своей вариант" - можем контролировать доступ к текстовому полю и делать редирект на пейвол'),
                                  duration: const Duration(seconds: 3),
                                  action: SnackBarAction(
                                    label: 'Close',
                                    onPressed: () {},
                                  ),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                return;
                              }
                            },
                            decoration: BoxDecoration(
                              color: textfieldAvailable
                                  ? Colors.white12
                                  : Colors.white30,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            placeholder: 'Type your message',
                            placeholderStyle: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () async {
                            await scriptProvider.restart();
                          },
                          child: const Text(
                            'RESTART',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            await scriptProvider.showPrevDay();
                          },
                          child: const Text(
                            '< Day',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            await scriptProvider.showNextDay();
                          },
                          child: const Text(
                            'Day >',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            await scriptProvider.showPrevMessage();
                          },
                          child: const Text(
                            '< Mess',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (needSendToScriptBot) {
                              await gptProvider.sendMessage(
                                  isNoScriptBot: false);
                              await scriptProvider.showNextMessage();
                            } else {
                              await gptProvider.sendMessage(
                                  isNoScriptBot: true);
                            }
                          },
                          child: const Text(
                            'SEND',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
