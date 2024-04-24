// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:typed_data';
import 'package:ai_friend/chat/chat_storage.dart';
import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/entity/i_script_message/i_script_message.dart';
import 'package:ai_friend/firebase/fire_storage.dart';
import 'package:ai_friend/locator.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final ChatStorage _storage;
  final List<IChatMessage> _messages = [];
  final _scrollController = ScrollController();
  final _textController = TextEditingController();
  final _chatListKey = GlobalKey<AnimatedListState>(debugLabel: '2');
  final _player = AudioPlayer();
  static const apiKey = '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';
  static const assistantId = 'asst_iUmxsDS4Eq39LdPTGKjWQPHC';

  List<IChatMessage> get messages => _messages;
  ScrollController get scrollController => _scrollController;
  TextEditingController get textController => _textController;
  GlobalKey<AnimatedListState> get chatListKey => _chatListKey;

  int get chatLengt => _messages.length;

  late String threadId;
  late String threadNoScriptId;
  late String runId;
  late String status;

  final openAI = OpenAI.instance.build(
    token: apiKey,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 10),
      connectTimeout: const Duration(seconds: 10),
    ),
    enableLog: true,
  );

  ChatProvider(this._storage);

  Future<void> initChat() async {
    final startMessage = IChatMessage(
      date: DateTime.now(),
      isPremiumContent: false,
      type: "text",
      isBot: true,
      content: "Hey, I think we should talk more. Let's start?😋",
    );

    if (_storage.messages.isEmpty) {
      await Future.delayed(const Duration(seconds: 2));
      _addNewMessage(startMessage);
      _storage.addMessage(startMessage);
    } else {
      _messages.addAll(_storage.messages);
      await Future.delayed(const Duration(seconds: 2));
      print('SCROLL');
      scrollController.jumpTo(scrollController.position.maxScrollExtent + 300);
    }
  }

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

  Future<void> sendMessageGetAnswer(IScriptMessage message) async {
    final answer = message.answer;
    if (answer!.isEmpty) return;

    final userMessage = IChatMessage(
      date: DateTime.now(),
      isPremiumContent: false,
      type: "text",
      isBot: false,
      content: message.text,
    );

    await _storage.addMessage(userMessage);
    _addNewMessage(userMessage);
    await Future.delayed(const Duration(milliseconds: 1000));

    for (var e in answer) {
      await Future.delayed(const Duration(milliseconds: 2200));
      saveMessageWithMedia(e);
      _addNewMessage(e);
    }
  }

  Future<void> saveMessageWithMedia(IChatMessage e) async {
    final firebaseProvider = locator<FireStorageProvider>();
    Uint8List? data;

    if (e.type.contains('text')) {
      await _storage.addMessage(e);
      return;
    }

    if (e.type.contains('video')) {
      data = await firebaseProvider.downloadVideo(e.content);
    }

    if (e.type.contains('image')) {
      data = await firebaseProvider.downloadImage(e.content);
    }

    final message = e.copyWith(mediaData: data);
    await _storage.addMessage(message);
  }

  Future<void> playIncomingMessageRingtone() async {
    await _player.play(
      AssetSource('new_message.mp3'),
      mode: PlayerMode.lowLatency,
    );
  }

  int _addNewMessage(IChatMessage message) {
    final index = chatLengt;
    _messages.add(message);
    _chatListKey.currentState?.insertItem(index);
    playIncomingMessageRingtone();
    scrollDown();
    return _messages.length;
  }

  Future<void> sendMessageToGPT() async {}
}
