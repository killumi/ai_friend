import 'package:ai_friend/features/chat/widgets/image_message.dart';
import 'package:ai_friend/features/chat/widgets/video_message.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

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
    return Row(
      mainAxisAlignment:
          message.isBot! ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        _buildMessage(),
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
            ? BotMessage(message: message.content)
            : UserMessage(message: message.content);
    }
  }
}

// ==========================================
// BOT MESSAGE WIDGET
// ==========================================
class BotMessage extends StatelessWidget {
  final String message;

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
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 16, right: 10, bottom: 13, top: 13),
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
      child: Text(
        message,
        style: const TextStyle(
          color: Color(0xFFFBFBFB),
          fontSize: 14,
          fontFamily: FontFamily.sFPro,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

// ==========================================
// USER MESSAGE WIDGET
// ==========================================

class UserMessage extends StatelessWidget {
  final String message;

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
        minHeight: 50,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 16, right: 10, bottom: 13, top: 13),
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
      child: Text(
        message,
        style: const TextStyle(
          color: Color(0xFFFBFBFB),
          fontSize: 14,
          fontFamily: FontFamily.sFPro,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
