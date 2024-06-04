import 'package:ai_friend/features/chat/chat_provider.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/features/chat/chat_script/widgets/chat_script_message.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/features/profile/name/name_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class ChatScriptMessagesBox extends StatelessWidget {
  const ChatScriptMessagesBox({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatScriptProvider>();
    final showAllBox = provider.isShowScriptBox;
    final isLoading = context.select((ChatProvider e) => e.isLoading);

    final runAnimation = isLoading || showAllBox;

    return provider.dailyScript == null && !isLoading
        ? const SizedBox(height: 1)
        : Stack(
            children: [
              ClipRRect(
                child: GestureDetector(
                  onTap: () => provider.toggleShowScriptBox(),
                  onVerticalDragEnd: (r) {
                    if (r.velocity.pixelsPerSecond.dy > 500) {
                      provider.showScriptBox(false);
                    } else {
                      provider.showScriptBox(true);
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 550),
                      curve: Curves.ease,
                      constraints: BoxConstraints(
                        minHeight: 1,
                        maxHeight: isLoading
                            ? 75
                            : showAllBox
                                ? 420
                                : 10,
                      ),
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 10, top: 16),
                      child: AnimatedOpacity(
                        opacity: runAnimation ? 1 : 0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                        child: IgnorePointer(
                          ignoring: !runAnimation,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                isLoading
                                    ? AnimatedOpacity(
                                        opacity: isLoading ? 1 : 0,
                                        curve: Curves.ease,
                                        duration:
                                            const Duration(milliseconds: 450),
                                        child: Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Lottie.asset(
                                                'assets/lottie_loader.json'),
                                          ),
                                        ),
                                      )
                                    : AnimatedOpacity(
                                        opacity: isLoading ? 0 : 1,
                                        curve: Curves.ease,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: Container(
                                          width: 36,
                                          height: 36,
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
                                              child:
                                                  Assets.icons.lightbulb.svg()),
                                        ),
                                      ),
                                const SizedBox(height: 12),
                                if (provider.dailyScript != null)
                                  AnimatedSize(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                    child: Text(
                                      provider.scriptMessage!.description
                                          .replaceUserName(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Color(0xFFFBFBFB),
                                        fontSize: 14,
                                        fontFamily: FontFamily.gothamPro,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                if (provider.dailyScript != null)
                                  Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      ...provider.scriptMessage!.messages
                                          .map(
                                              (e) => ChatScriptMessage(data: e))
                                          .toList(),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
