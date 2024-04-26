import 'package:ai_friend/chat/chat_provider.dart';
import 'package:ai_friend/chat/chat_script/chat_script_helper.dart';
import 'package:ai_friend/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/entity/i_script_message/i_script_message.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScriptMessage extends StatelessWidget {
  final IScriptMessage data;

  const ChatScriptMessage({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      tilt: false,
      onTap: () => sendAnswer(context),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(
          top: 12,
          left: 16,
          right: 16,
          bottom: 12,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: data.isPremium
            ? ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-0.91, 0.1),
                  end: Alignment(0.71, -0.71),
                  colors: [Color(0xFFA762EA), Color(0xFFBB3DA0)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x7FA762EA),
                    blurRadius: 15,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              )
            : ShapeDecoration(
                color: const Color(0xff341B44),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Color(0xFFAC57D5)),
                  borderRadius: BorderRadius.circular(15),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x7FA762EA),
                    blurRadius: 15,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
        child: Row(
          children: [
            if (data.isPremium) Assets.icons.proIcon.svg(),
            if (data.isPremium) const SizedBox(width: 8),
            Expanded(
              child: Text(
                data.text.replaceUserName(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnack(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 12),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void sendAnswer(BuildContext context) async {
    final scriptProvider = context.read<ChatScriptProvider>();
    final chatProvider = context.read<ChatProvider>();

    if (data.action!.isNotEmpty) {
      switch (data.action) {
        case 'no_send_pay_go_next_day':
          showSnack(context,
              'Это сообщение с кастомным экшеном "no_send_pay_go_next_day" - оно никуда не отправляется - нужно для платной перемотки сценария на следующий день. Пока что переключение на следующий день не ограничиваю для удобного тестирования');
          await scriptProvider.showNextMessage();
          return;
        case 'no_send_pay_unlock_textfield':
          showSnack(context,
              'Это сообщение с кастомным экшеном "no_send_pay_unlock_textfield" - оно никуда не отправляется - нужно чтобы редиректнуть на пейвол и платно разблокировать текстовое поле для общения с флиртующим ботом потому что у нас закончилс сценарий');
          // scriptProvider.unlock(true);
          scriptProvider.restart();
          return;
        default:
          return;
      }
    }

    await chatProvider.sendMessageGetAnswer(data);
    await scriptProvider.showNextMessage();
  }
}
