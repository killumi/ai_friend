// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';

class GPTProvider extends ChangeNotifier {
  static const apiKey = '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';
  static const assistantId = 'asst_9b2mWIT9rp0BZWzwhn3l92Mf';
  static const assistantNoScriptId = 'asst_iUmxsDS4Eq39LdPTGKjWQPHC';

  final textController = TextEditingController();
  final scrollController = ScrollController();

  late String threadId;
  late String threadNoScriptId;
  late String runId;
  late String status;
  final messages = [
    IChatMessage(
      date: DateTime.now(),
      isPremiumContent: false,
      type: "text",
      isBot: true,
      content: "Hey, I think we should talk more. Let's start?😋",
    ),
  ];

  final openAI = OpenAI.instance.build(
    token: apiKey,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 10),
      connectTimeout: const Duration(seconds: 10),
    ),
    enableLog: true,
  );

  void scrollDown() async {
    await Future.delayed(const Duration(seconds: 1));
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  Future<void> createThreads() async {
    final thread = await openAI.threads.createThread(request: ThreadRequest());
    final threadNoScript =
        await openAI.threads.createThread(request: ThreadRequest());
    threadId = thread.id;
    threadNoScriptId = threadNoScript.id;
    notifyListeners();
  }

  Future<void> sendMessage({String? value, bool isNoScriptBot = false}) async {
    final resultThreadId = isNoScriptBot ? threadNoScriptId : threadId;
    final resultAssistantId = isNoScriptBot ? assistantNoScriptId : assistantId;
    final content = value ?? textController.text.trim();
    if (content.isEmpty) return;

    // CREATE MESSAGE
    await openAI.threads.messages.createMessage(
      threadId: resultThreadId,
      request: CreateMessage(
        role: 'user',
        content: content,
      ),
    );

    // ADD NEW MESSAGE TO UI LIST
    messages.add(
      IChatMessage(
        date: DateTime.now(),
        isPremiumContent: false,
        type: "text",
        isBot: false,
        content: content,
      ),
    );
    // CLEAR TEXT FIELD
    textController.clear();
    notifyListeners();
    scrollDown();
    // log('mess: ${mess.toJson()}');
    // CREATE RUN
    final run = await openAI.threads.runs.createRun(
      threadId: resultThreadId,
      request: CreateRun(assistantId: resultAssistantId),
    );
    // SET RUN ID and STATUS
    runId = run.id;
    status = run.status;
    // log('run: ${run.toJson()}');
    // log('status: $status');

    while (status != "completed") {
      final retrived = await openAI.threads.runs.retrieveRun(
        threadId: isNoScriptBot ? threadNoScriptId : threadId,
        runId: runId,
      );
      status = retrived.status;
      runId = retrived.id;
      if (isNoScriptBot) {
        threadNoScriptId = retrived.threadId;
      } else {
        threadId = retrived.threadId;
      }
      // print('status 2: $status');
    }

    final msgs = await openAI.threads.messages.listMessage(
      threadId: isNoScriptBot ? threadNoScriptId : threadId,
    );
    final lastMsg = msgs.data[0].content[0].text!.value;
    // log('${lastMsg}');
    // log('=======================');
    // log('=======================');
    // log('=======================');
    log('LAST MESSAGE: $lastMsg');

    final splitted = lastMsg.split('+');

    if (splitted.first.isNotEmpty) {
      final parced = removeQuotesIfNeeded(splitted.first);
      print('parced first: $parced');

      messages.add(
        IChatMessage(
          date: DateTime.now(),
          isPremiumContent: false,
          type: "text",
          isBot: true,
          content: parced,
        ),
      );
      notifyListeners();
      scrollDown();
    }

    if (splitted.last.isNotEmpty) {
      print('LAST MESS LAST PART SPLIT: ${splitted.last} ');
      if (splitted.last.contains('type')) {
        final parced = removeQuotesIfNeeded(splitted.last);
        print('parced last: $parced');
        final decoded = jsonDecode(parced) as List<dynamic>;
        for (var media in decoded) {
          await Future.delayed(const Duration(seconds: 2));
          scrollDown();
          final mediaMessage = IChatMessage.fromMap(media);
          messages.add(mediaMessage);
          notifyListeners();
        }
      }
    }
  }

  String removeQuotesIfNeeded(String input) {
    if (input.isEmpty) {
      return input;
    }

    bool startsWithQuote = input.startsWith('"') || input.startsWith('«');
    bool endsWithQuote = input.endsWith('"') || input.endsWith('»');
    if ((startsWithQuote || endsWithQuote) && input.length >= 2) {
      if (startsWithQuote && !endsWithQuote) {
        return input.substring(1);
      } else if (!startsWithQuote && endsWithQuote) {
        return input.substring(0, input.length - 1);
      }
    }
    return input;
  }
}
