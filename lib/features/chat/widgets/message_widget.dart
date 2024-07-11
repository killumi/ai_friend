// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/features/chat/chat_provider.dart';
import 'package:ai_friend/features/chat/widgets/image_message.dart';
import 'package:ai_friend/features/chat/widgets/video_message.dart';
import 'package:ai_friend/gen/fonts.gen.dart';

class MessageWidget extends StatefulWidget {
  final IChatMessage message;

  const MessageWidget({required this.message, super.key});

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  IChatMessage get message => widget.message;

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    // return GestureDetector(
    //   onDoubleTap: () async {
    //     FirebaseAnaliticsService.logOnLikeMessage();
    //     await chatProvider.toggleLikeMessage(message);
    //   },
    //   onTap: () {
    //     log('INIT WEB VIDEO:');
    //     print('INIT WEB VIDEO:');
    //   },
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Row(
    //         mainAxisAlignment: message.isBot!
    //             ? MainAxisAlignment.start
    //             : MainAxisAlignment.end,
    //         children: [
    //           _buildMessage(),
    //         ],
    //       ),
    //       if (message.isImage || message.isVideo)
    //         MessageLikeWidget(message: message),
    //       const SizedBox(height: 8),
    //     ],
    //   ),
    // );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              message.isBot! ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            _buildMessage(),
          ],
        ),
        if (message.isImage || message.isVideo)
          MessageLikeWidget(message: message),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildMessage() {
    switch (message.type) {
      case 'video':
        return VideoMessage(message: message);
      case 'image':
        return ImageMessage(message: message);
      default:
        return message.isBot!
            ? BotMessage(message: message)
            : UserMessage(message: message);
    }
  }
}

// ==========================================
// BOT MESSAGE WIDGET
// ==========================================
class BotMessage extends StatelessWidget {
  final IChatMessage message;

  const BotMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 296,
        minWidth: 106,
        minHeight: 50,
      ),
      padding: EdgeInsets.only(
          left: 16,
          right: 10,
          bottom: message.isLiked ?? false ? 8 : 12,
          top: 10),
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(1.00, -0.03),
          end: Alignment(-1, 0.03),
          colors: [Color(0xFF544966), Color(0xFF3F3350)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.content,
            style: const TextStyle(
              color: Color(0xFFFBFBFB),
              fontSize: 14,
              fontFamily: FontFamily.sFPro,
              fontWeight: FontWeight.w400,
            ),
          ),
          MessageLikeWidget(message: message),
        ],
      ),
    );
  }
}

// ==========================================
// USER MESSAGE WIDGET
// ==========================================

class UserMessage extends StatelessWidget {
  final IChatMessage message;

  const UserMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 296,
        minWidth: 106,
        minHeight: 40,
      ),
      padding: EdgeInsets.only(
          left: 16,
          right: 10,
          bottom: message.isLiked ?? false ? 8 : 12,
          top: 10),
      clipBehavior: Clip.antiAlias,
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.71, 0.71),
          end: Alignment(0.71, -0.71),
          colors: [Color(0xFFBB3DA0), Color(0xFFA762EA)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.content,
            style: const TextStyle(
              color: Color(0xFFFBFBFB),
              fontSize: 14,
              fontFamily: FontFamily.sFPro,
              fontWeight: FontWeight.w400,
            ),
          ),
          MessageLikeWidget(message: message),
        ],
      ),
    );
  }
}

class MessageLikeWidget extends StatelessWidget {
  final IChatMessage message;

  const MessageLikeWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.read<ChatProvider>();

    return SizedBox(
      width: 45,
      child: Center(
        child: GestureDetector(
          onTap: () {
            chatProvider.toggleLikeMessage(message);
            FirebaseAnaliticsService.logOnLikeMessage();
          },
          child: AnimatedScale(
            scale: message.isLiked ?? false ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutBack,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(top: message.isLiked ?? false ? 4 : 0),
              curve: Curves.ease,
              clipBehavior: Clip.hardEdge,
              width: message.isLiked ?? false ? 45 : 0,
              height: message.isLiked ?? false ? 24 : 0,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: AnimatedOpacity(
                  opacity: message.isLiked ?? false ? 1 : 0,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.ease,
                  child: const Icon(
                    Icons.favorite,
                    color: Color(0xffFE0300),
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
