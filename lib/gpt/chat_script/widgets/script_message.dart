// import 'package:ai_friend/entity/i_script_message/i_script_message.dart';
// import 'package:ai_friend/gpt/chat_script/chat_script_provider.dart';
// import 'package:ai_friend/gpt/gpt_provider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ScriptMessage extends StatelessWidget {
//   final IScriptMessage data;

//   const ScriptMessage({required this.data, super.key});

//   @override
//   Widget build(BuildContext context) {
//     final gptProvider = context.read<GPTProvider>();
//     final scriptProvider = context.read<ChatScriptProvider>();

//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(bottom: 10),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.deepPurple,
//           padding: const EdgeInsets.all(10),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         onPressed: () async {
//           if (data.action!.isNotEmpty) {
//             switch (data.action) {
//               case 'no_send_pay_go_next_day':
//                 showSnack(context,
//                     'Это сообщение с кастомным экшеном "no_send_pay_go_next_day" - оно никуда не отправляется - нужно для платной перемотки сценария на следующий день. Пока что переключение на следующий день не ограничиваю для удобного тестирования');
//                 await scriptProvider.showNextMessage();
//                 return;
//               case 'no_send_pay_unlock_textfield':
//                 showSnack(context,
//                     'Это сообщение с кастомным экшеном "no_send_pay_unlock_textfield" - оно никуда не отправляется - нужно чтобы редиректнуть на пейвол и платно разблокировать текстовое поле для общения с флиртующим ботом потому что у нас закончилс сценарий');
//                 scriptProvider.unlock(true);
//                 return;
//               default:
//                 return;
//             }
//           }

//           print('object');

//           if (data.isScriptBot ?? false) {
//             await gptProvider.sendMessage(value: data.text);
//           } else {
//             await gptProvider.sendMessage(
//               value: data.text,
//               isNoScriptBot: true,
//             );
//           }
//           await scriptProvider.showNextMessage();
//         },
//         child: Row(
//           children: [
//             if (data.isPremium)
//               const Icon(
//                 CupertinoIcons.money_dollar,
//                 color: Colors.green,
//                 size: 30,
//               ),
//             Expanded(
//               child: Text(
//                 data.text,
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void showSnack(BuildContext context, String text) {
//     final snackBar = SnackBar(
//       content: Text(text),
//       duration: const Duration(seconds: 12),
//       action: SnackBarAction(
//         label: 'Close',
//         onPressed: () {},
//       ),
//     );

//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
