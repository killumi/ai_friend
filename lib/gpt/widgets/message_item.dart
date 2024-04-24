// import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
// import 'package:ai_friend/gpt/widgets/pic_message.dart';
// import 'package:ai_friend/gpt/widgets/video_message.dart';
// import 'package:flutter/material.dart';

// class MessageItem extends StatefulWidget {
//   final IChatMessage message;

//   const MessageItem({required this.message, super.key});

//   @override
//   State<MessageItem> createState() => _MessageItemState();
// }

// class _MessageItemState extends State<MessageItem> {
//   IChatMessage get message => widget.message;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment:
//           message.isBot! ? MainAxisAlignment.start : MainAxisAlignment.end,
//       children: [
//         _buildMessage(),
//       ],
//     );
//   }

//   Widget _buildMessage() {
//     switch (message.type) {
//       case 'video':
//         return VideoMessageWidget(message: message);

//       case 'image':
//         return PicMessage(message: message);
//       default:
//         return Container(
//           constraints: const BoxConstraints(minWidth: 110, maxWidth: 300),
//           margin: const EdgeInsets.only(bottom: 10),
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: message.isBot! ? Colors.greenAccent : Colors.purpleAccent,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Text(message.content),
//         );
//     }
//   }
// }

// // =======================
// // =======================
// // =======================
