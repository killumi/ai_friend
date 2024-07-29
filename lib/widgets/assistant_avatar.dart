// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

import 'package:ai_friend/domain/entity/i_assistant/i_assistant.dart';

class AssistantAvatar extends StatelessWidget {
  final IAssistant assistant;
  final double? size;

  const AssistantAvatar({
    Key? key,
    required this.assistant,
    this.size = 48,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const ShapeDecoration(
        color: Color(0xFF270E3B),
        // color: Color(0xFF170C22),
        shape: OvalBorder(),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: _isValidUrl(assistant.avatar)
            ? Image.network(
                assistant.avatar,
                fit: BoxFit.cover,
              )
            : Center(
                child: Text(
                  assistant.name[0],
                  style: const TextStyle(
                    color: Color(0xFFFBFBFB),
                    fontSize: 19,
                    fontFamily: FontFamily.gothamPro,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
      ),
    );
  }

  bool _isValidUrl(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }
}
