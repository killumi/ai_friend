import 'package:ai_friend/features/chat/chat_provider.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/domain/services/locator.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  ChatProvider get chatProvider => locator<ChatProvider>();
  ChatScriptProvider get scriptProvider => locator<ChatScriptProvider>();

  @override
  void initState() {
    super.initState();
    chatProvider.node.addListener(chatProvider.onChangeFocusListener);
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.read<ChatProvider>();
    final scriptProvider = context.read<ChatScriptProvider>();
    final isShowScriptBox =
        context.select((ChatScriptProvider e) => e.isShowScriptBox);
    final textfieldAvailable =
        context.select((ChatScriptProvider e) => e.textfieldAvailable);
    // final currentScriptMessageData =
    //     context.select((ChatScriptProvider e) => e.scriptMessage);
    final isShowRollUpBoxButton =
        context.select((ChatScriptProvider e) => e.isShowRollUpBoxButton);
    final isHasFocus = context.select((ChatProvider e) => e.isHasFocus);
    final isHasPremium = context.select((PaymentProvider e) => e.isHasPremium);
    final showSendButton = context.select((ChatProvider e) => e.showSendButton);
    // final scriptIsEnded =
    // context.select((ChatScriptProvider e) => e.dailyScript) == null;

    return GestureDetector(
      onVerticalDragEnd: (r) {
        if (r.velocity.pixelsPerSecond.dy > 500) {
          chatProvider.node.unfocus();
        }
      },
      child: AnimatedContainer(
        padding: EdgeInsets.only(
            top: 10, left: 16, right: 16, bottom: isHasFocus ? 16 : 0),
        duration: const Duration(milliseconds: 240),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 56,
                child: CupertinoTextField(
                  focusNode: chatProvider.node,
                  controller: chatProvider.textController,
                  onChanged: chatProvider.onChangeTextValue,
                  onTapOutside: (e) {
                    chatProvider.node.unfocus();
                  },
                  readOnly: !isHasPremium && !textfieldAvailable,
                  onTap: () {
                    if (!isHasPremium && !textfieldAvailable) {
                      chatProvider.node.unfocus();
                      // AppRouter.openPaywall(context, false);
                      scriptProvider.showScriptBox(true);
                    }
                    // print('object');
                    return;
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  prefix: isHasPremium
                      ? null
                      : Container(
                          alignment: Alignment.centerRight,
                          width: 35,
                          child: Icon(
                            textfieldAvailable
                                ? CupertinoIcons.lock_open
                                : CupertinoIcons.lock,
                            color: Colors.white54,
                          ),
                        ),
                  suffix: isHasFocus
                      ? AnimatedScale(
                          scale: showSendButton ? 1 : 0,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.ease,
                          child: AnimatedOpacity(
                            opacity: showSendButton ? 1 : 0,
                            duration: const Duration(milliseconds: 260),
                            curve: Curves.ease,
                            child: Bounce(
                              onTap: () async {
                                // if (textfieldAvailable) {
                                // await chatProvider.sendMessageGetAnswer(
                                //   null,
                                //   messageData: currentScriptMessageData,
                                // );
                                // chatProvider.node.unfocus();
                                // scriptProvider.showScriptBox(true);

                                // await scriptProvider.showNextMessage();
                                // } else {
                                // }
                                chatProvider.sendMessageToGPT();
                              },
                              tilt: false,
                              scaleFactor: 0.89,
                              child: Container(
                                width: 48,
                                height: 48,
                                margin: const EdgeInsets.only(right: 4),
                                decoration: const ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(-0.71, 0.71),
                                    end: Alignment(0.71, -0.71),
                                    colors: [
                                      Color(0xFFBB3DA0),
                                      Color(0xFFA762EA)
                                    ],
                                  ),
                                  shape: OvalBorder(),
                                ),
                                child: Center(
                                  child: Assets.icons.messageIcon.svg(),
                                ),
                              ),
                            ),
                          ),
                        )
                      : AnimatedScale(
                          scale:
                              isShowRollUpBoxButton && !isShowScriptBox ? 1 : 0,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.ease,
                          child: AnimatedOpacity(
                            opacity: isShowRollUpBoxButton && !isShowScriptBox
                                ? 1
                                : 0,
                            duration: const Duration(milliseconds: 260),
                            curve: Curves.ease,
                            child: Bounce(
                              onTap: () {
                                scriptProvider.showScriptBox(true);
                                chatProvider.scrollDown();
                              },
                              tilt: false,
                              scaleFactor: 0.89,
                              child: Container(
                                width: 48,
                                height: 48,
                                margin: const EdgeInsets.only(right: 4),
                                decoration: const ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(-0.71, 0.71),
                                    end: Alignment(0.71, -0.71),
                                    colors: [
                                      Color(0xFFBB3DA0),
                                      Color(0xFFA762EA)
                                    ],
                                  ),
                                  shape: OvalBorder(),
                                ),
                                child: Center(
                                  child: Assets.icons.lightbulb.svg(),
                                ),
                              ),
                            ),
                          ),
                        ),
                  decoration: BoxDecoration(
                    color: const Color(0xff322835),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xff88848B),
                    ),
                  ),
                  placeholder: 'Type a message...',
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
      ),
    );
  }
}
