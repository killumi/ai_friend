// // ignore_for_file: use_build_context_synchronously
// import 'dart:developer';

// import 'package:ai_friend/domain/firebase/firebase_config.dart';
// import 'package:ai_friend/features/chat/chat_provider.dart';
// import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
// import 'package:ai_friend/features/chat/chat_script/widgets/chat_script_messages_box.dart';
// import 'package:ai_friend/features/chat/widgets/chat_header.dart';
// import 'package:ai_friend/features/chat/widgets/chat_input.dart';
// import 'package:ai_friend/features/chat/widgets/continue_chat_widget.dart';
// import 'package:ai_friend/features/chat/widgets/message_widget.dart';
// import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
// import 'package:ai_friend/features/payment/payment_provider.dart';
// import 'package:ai_friend/domain/services/locator.dart';
// import 'package:ai_friend/widgets/screen_wrap.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';

// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const ChatScreenView();
//   }
// }

// class ChatScreenView extends StatefulWidget {
//   const ChatScreenView({super.key});

//   @override
//   State<ChatScreenView> createState() => _ChatScreenViewState();
// }

// class _ChatScreenViewState extends State<ChatScreenView> {
//   late ChatProvider provider;
// bool get showMedia => locator<FirebaseConfig>().showMedia;

//   @override
//   void initState() {
//     super.initState();
//     provider = context.read<ChatProvider>();
//     provider.chatListKey = GlobalKey<AnimatedListState>();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await provider.initChat();
//     });
//   }

//   @override
//   void dispose() {
//     provider.scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final chatProvider = context.watch<ChatProvider>();
//     final messages = chatProvider.messages;
//     final listKey = chatProvider.chatListKey;
//     final scrollController = chatProvider.scrollController;
//     final isLoading = chatProvider.isLoading;
//     log('isLoading : $isLoading');

// // final daylyScriptIsEnd =
// //     context.select((ChatScriptProvider e) => e.showEndDayUI);
// // final needShowPremiumBanner =
// //     context.select((ChatScriptProvider e) => e.needShowPremiumBanner);
// final isHasPremium = context.select((PaymentProvider e) => e.isHasPremium);

//     return ScreenWrap(
//       resizeToAvoidBottomInset: true,
//       child: Stack(
//         children: [
//           SafeArea(
//             child: Column(
//               children: [
//                 Expanded(
//                   child: isLoading
//                       ? const Center(
//                           child: CupertinoActivityIndicator(),
//                         )
//                       : AnimatedList(
//                           controller: scrollController,
//                           padding: const EdgeInsets.all(16)
//                               .copyWith(top: 100, bottom: 25),
//                           key: listKey,
//                           initialItemCount: messages.length,
//                           itemBuilder: (context, index, animation) =>
//                               _buildItem(messages[index], animation),
//                         ),
//                 ),
// // if (!needShowPremiumBanner && !daylyScriptIsEnd || isHasPremium)
// // const ChatScriptMessagesBox(),
// // if (!needShowPremiumBanner && !daylyScriptIsEnd || isHasPremium)
// const ChatInput(),
// // if (daylyScriptIsEnd && !isHasPremium)
// // const ContinueChatWidget(
// //   title:
// //       'Alice will be online in 12 hours. You can get a PRO and continue chatting with her right away',
// // ),
// // if (needShowPremiumBanner && !isHasPremium)
// //   ContinueChatWidget(
// //     title: !showMedia
// //         ? 'To continue chatting with Alice, upgrade to PRO'
// //         : 'To keep chatting with Alice and receiving her photos and videos, upgrade to PRO',
// //   ),
//               ],
//             ),
//           ),
//           const ChatHeader(),
//         ],
//       ),
//     );
//   }

//   Widget _buildItem(IChatMessage message, Animation<double> animation) {
//     final slideTween = Tween<Offset>(
//       begin: const Offset(0, 1),
//       end: Offset.zero,
//     );

//     return SlideTransition(
//       key: UniqueKey(),
//       position: animation.drive(slideTween),
//       child: FadeTransition(
//         opacity: animation,
//         child: MessageWidget(message: message),
//       ),
//     );
//   }
// }

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
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeChat());
  }

  Future<void> _initializeChat() async {
    await context.read<ChatScriptProvider>().initScript();
    await provider.createThread();
    await provider.initChat();
    if (mounted) {
      setState(() {
        _isChatInitialized = true;
        _showOverlay = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    final messages = chatProvider.messages;
    final listKey = chatProvider.chatListKey;
    final scrollController = chatProvider.scrollController;
    final daylyScriptIsEnd =
        context.select((ChatScriptProvider e) => e.showEndDayUI);
    final needShowPremiumBanner =
        context.select((ChatScriptProvider e) => e.needShowPremiumBanner);
    final isHasPremium = context.select((PaymentProvider e) => e.isHasPremium);

    // final isLoading = chatProvider.isLoading;

    return ScreenWrap(
      resizeToAvoidBottomInset: true,
      child: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: !_isChatInitialized
                      ? const Center(
                          child: CupertinoActivityIndicator(
                            radius: 14,
                            color: Colors.white,
                          ),
                        )
                      : AnimatedList(
                          controller: scrollController,
                          padding: const EdgeInsets.all(16)
                              .copyWith(top: 100, bottom: 25),
                          key: listKey,
                          initialItemCount: messages.length,
                          itemBuilder: (context, index, animation) =>
                              _buildItem(messages[index], animation),
                        ),
                ),
                if (!needShowPremiumBanner && !daylyScriptIsEnd || isHasPremium)
                  const ChatScriptMessagesBox(),
                if (!needShowPremiumBanner && !daylyScriptIsEnd || isHasPremium)
                  const ChatInput(),
                if (daylyScriptIsEnd && !isHasPremium)
                  const ContinueChatWidget(
                    title:
                        'Alice will be online in 12 hours. You can get a PRO and continue chatting with her right away',
                  ),
                if (needShowPremiumBanner && !isHasPremium)
                  ContinueChatWidget(
                    title: !showMedia
                        ? 'To continue chatting with Alice, upgrade to PRO'
                        : 'To keep chatting with Alice and receiving her photos and videos, upgrade to PRO',
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
    );

    return SlideTransition(
      key: UniqueKey(),
      position: animation.drive(slideTween),
      child: FadeTransition(
        opacity: animation,
        child: MessageWidget(message: message),
      ),
    );
  }
}
