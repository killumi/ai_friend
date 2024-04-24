import 'package:ai_friend/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _node = FocusNode();
  final _controller = TextEditingController();
  bool showButton = false;
  bool isHasFocus = false;

  double get height => MediaQuery.of(context).size.height;
  bool get safeBottom => height < 750;
  @override
  void initState() {
    super.initState();
    _node.addListener(() {
      isHasFocus = _node.hasFocus;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final scriptProvider = context.read<ChatScriptProvider>();

    return AnimatedContainer(
      padding:
          EdgeInsets.only(left: 16, right: 16, bottom: isHasFocus ? 16 : 0),
      duration: const Duration(milliseconds: 240),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 56,
              child: CupertinoTextField(
                focusNode: _node,
                controller: _controller,
                onChanged: (e) {
                  if (e.isNotEmpty) {
                    showButton = true;
                  } else {
                    showButton = false;
                  }

                  setState(() {});
                },
                padding: const EdgeInsets.symmetric(horizontal: 16),
                suffix: AnimatedScale(
                  scale: showButton ? 1 : 0,
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.ease,
                  child: AnimatedOpacity(
                    opacity: showButton ? 1 : 0,
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.ease,
                    child: Bounce(
                      onTap: () {
                        scriptProvider.showNextMessage();
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
                            colors: [Color(0xFFBB3DA0), Color(0xFFA762EA)],
                          ),
                          shape: OvalBorder(),
                        ),
                        child: Center(
                          child: Assets.icons.messageIcon.svg(),
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
    );
  }
}
