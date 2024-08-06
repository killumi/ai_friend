import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/domain/firebase/firebase_config.dart';
import 'package:ai_friend/domain/services/locator.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/features/chat/chat_script/widgets/chat_script_messages_box.dart';
import 'package:ai_friend/features/chat/widgets/chat_header.dart';
import 'package:ai_friend/features/chat/widgets/chat_input.dart';
import 'package:ai_friend/features/chat/widgets/continue_chat_widget.dart';
import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_friend/features/chat/chat_provider.dart';
import 'package:ai_friend/features/chat/widgets/message_widget.dart';
import 'package:ai_friend/widgets/screen_wrap.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatProvider provider;
  bool _isChatInitialized = false;
  bool _showOverlay = true;

  bool get showMedia => locator<FirebaseConfig>().showMedia;

  @override
  void initState() {
    super.initState();
    provider = context.read<ChatProvider>();
    provider.chatListKey = GlobalKey<AnimatedListState>();
    provider.node = FocusNode();
    provider.textController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeChat());
  }

  Future<void> _initializeChat() async {
    await provider.createThread();
    await provider.initChat();
    if (mounted) {
      setState(() {
        _isChatInitialized = true;
      });

      await Future.delayed(const Duration(milliseconds: 500));
      _showOverlay = false;
      setState(() {
        provider.scrollDown(animate: false, min: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.read<ChatProvider>();
    final messages = chatProvider.messages;
    final listKey = chatProvider.chatListKey;
    final scrollController = chatProvider.scrollController;
    final isShowScriptWidgets =
        context.select((ChatScriptProvider e) => e.isShowScriptWidgets);
    final showPremiumBanner =
        context.select((ChatScriptProvider e) => e.showPremiumBanner);
    final isHasPremium = context.select((PaymentProvider e) => e.isHasPremium);

    return ScreenWrap(
      resizeToAvoidBottomInset: true,
      child: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                Expanded(
                  child: !_isChatInitialized
                      ? const Center(
                          child: CupertinoActivityIndicator(
                            radius: 14,
                            color: Colors.white,
                          ),
                        )
                      : AnimatedList(
                          shrinkWrap: true,
                          controller: scrollController,
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 25, top: 30),
                          key: listKey,
                          initialItemCount: messages.length,
                          itemBuilder: (context, index, animation) =>
                              _buildItem(messages[index], animation),
                        ),
                ),
                if (!showPremiumBanner && isShowScriptWidgets || isHasPremium)
                  const ChatScriptMessagesBox(),
                if (!showPremiumBanner || isHasPremium) const ChatInput(),
                if (showPremiumBanner && !isHasPremium)
                  ContinueChatWidget(
                    title: !showMedia
                        ? 'To continue chatting with ${chatProvider.currentAssistant.name}, upgrade to PRO'
                        : 'To keep chatting with ${chatProvider.currentAssistant.name} and receiving her photos and videos, upgrade to PRO',
                  ),
              ],
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              ignoring: !_showOverlay,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 550),
                curve: Curves.ease,
                opacity: _showOverlay ? 1 : 0,
                child: const ScreenWrap(
                    child: Center(
                  child: CupertinoActivityIndicator(
                    radius: 14,
                    color: Colors.white,
                  ),
                )),
              ),
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
    ).chain(CurveTween(curve: Curves.easeOut));

    return SlideTransition(
      position: animation.drive(slideTween),
      child: FadeTransition(
        opacity: animation,
        child: MessageWidget(message: message),
      ),
    );
  }
}
