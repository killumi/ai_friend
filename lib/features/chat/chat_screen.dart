// ignore_for_file: use_build_context_synchronously
import 'package:ai_friend/features/chat/chat_provider.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/features/chat/chat_script/widgets/chat_script_messages_box.dart';
import 'package:ai_friend/features/chat/widgets/chat_header.dart';
import 'package:ai_friend/features/chat/widgets/chat_input.dart';
import 'package:ai_friend/features/chat/widgets/continue_chat_widget.dart';
import 'package:ai_friend/features/chat/widgets/message_widget.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ChatProvider>().initChat().then((value) async {
        await Future.delayed(const Duration(seconds: 1));
        context.read<ChatScriptProvider>().initScript();
        context.read<ChatScriptProvider>().showScriptBox(true);
        context.read<ChatProvider>().scrollDown();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    final messages = chatProvider.messages;
    final listKey = chatProvider.chatListKey;
    final scrollController = chatProvider.scrollController;
    final daylyScriptIsEnd =
        context.select((ChatScriptProvider e) => e.daylyScriptIsEnd);

    return ScreenWrap(
      resizeToAvoidBottomInset: true,
      child: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: AnimatedList(
                    controller: scrollController,
                    padding:
                        const EdgeInsets.all(16).copyWith(top: 100, bottom: 25),
                    key: listKey,
                    initialItemCount: messages.length,
                    itemBuilder: (context, index, animation) =>
                        _buildItem(messages[index], animation),
                  ),
                ),
                if (!daylyScriptIsEnd) const ChatScriptMessagesBox(),
                if (!daylyScriptIsEnd) const ChatInput(),
                if (daylyScriptIsEnd) const ContinueChatWidget(),
              ],
            ),
          ),
          const ChatHeader(),
        ],
      ),
    );
  }

  Widget _buildItem(IChatMessage message, Animation<double> animation) {
    final slideTween = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    );

    return SlideTransition(
      position: animation.drive(slideTween),
      child: FadeTransition(
        opacity: animation,
        child: MessageWidget(message: message),
      ),
    );
  }
}
