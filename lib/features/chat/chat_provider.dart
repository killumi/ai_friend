// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:ai_friend/domain/firebase/firebase_config.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/features/chat/chat_storage.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/domain/entity/i_script_message/i_script_message.dart';
import 'package:ai_friend/domain/entity/i_script_message_data/i_script_message_data.dart';
import 'package:ai_friend/domain/firebase/fire_storage.dart';
import 'package:ai_friend/locator.dart';
import 'package:ai_friend/features/profile/name/name_helper.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final ChatStorage _storage;
  final ChatScriptProvider _chatScriptProvider;
  final List<IChatMessage> _messages = [];
  final firebaseConfig = locator<FirebaseConfig>();

  bool isHasFocus = false;
  bool showSendButton = false;
  bool isLoading = false;
  final _scrollController = ScrollController();
  final _textController = TextEditingController();
  final _node = FocusNode();
  // final _chatListKey = GlobalKey<AnimatedListState>(debugLabel: '2');
  late GlobalKey<AnimatedListState> chatListKey;

  final _player = AudioPlayer();
  static const apiKey = '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';
  static const assistantId = 'asst_iUmxsDS4Eq39LdPTGKjWQPHC';

  List<IChatMessage> get messages => _messages;
  ScrollController get scrollController => _scrollController;
  TextEditingController get textController => _textController;
  FocusNode get node => _node;

  // GlobalKey<AnimatedListState> get chatListKey => _chatListKey;

  int get chatLengt => _messages.length;

  late String threadId;
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

  ChatProvider(this._storage, this._chatScriptProvider);

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
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  Future<void> initMessages() async {
    if (_storage.messages.isNotEmpty) {
      // print('_storage.messages: ${_storage.messages}');
      _messages.addAll(_storage.messages);
    }
    notifyListeners();
  }

  // ================================================
  // SCRIPT CHAT
  // ================================================
  Future<void> sendMessageGetAnswer(IScriptMessage? message,
      {IScriptMessageData? messageData}) async {
    if (message == null && messageData == null) return;
    showLoader(true);
    final userMessage = IChatMessage(
      date: DateTime.now(),
      isPremiumContent: false,
      type: "text",
      isBot: false,
      content: messageData != null
          ? textController.text.trim()
          : message?.text.replaceUserName() ?? '',
    );

    _addNewMessage(userMessage);
    _textController.clear();
    // sendMessageToGPT(customValue: userMessage.content, isBot: false);
    await _storage.addMessage(userMessage);
    await Future.delayed(const Duration(milliseconds: 1000));
    final answer = message?.answer ?? messageData?.answer;
    if (answer == null || answer.isEmpty) {
      showLoader(false);
      scrollDown();
      return;
    }
    final random = math.Random();
    final milliseconds = random.nextInt(3001) + 1850;
    // print('Delayed for $milliseconds milliseconds');
    for (var e in answer) {
      await Future.delayed(Duration(milliseconds: milliseconds));
      // await Future.delayed(const Duration(milliseconds: 200));
      // await Future.delayed(Duration(milliseconds: 1000));
      e = e.copyWith(content: e.content.replaceUserName());

      saveMessageWithMedia(e);
      _addNewMessage(e);
    }
    await Future.delayed(const Duration(seconds: 1));
    showLoader(false);
    scrollDown();
  }

  Future<void> saveMessageWithMedia(IChatMessage e) async {
    final firebaseProvider = locator<FireStorageProvider>();
    Uint8List? data;

    if (e.type.contains('text')) {
      await _storage.addMessage(e);
      return;
    }
    if (e.isImage && !firebaseConfig.showMedia ||
        e.isVideo && !firebaseConfig.showMedia) return;

    if (e.type.contains('video')) {
      data = await firebaseProvider.downloadVideo(e.content);
    }

    if (e.type.contains('image')) {
      data = await firebaseProvider.downloadImage(e.content);
    }

    final message = e.copyWith(mediaData: data);
    await _storage.addMessage(message);
    notifyListeners();
  }

  void _addNewMessage(IChatMessage message) {
    if (message.isImage && !firebaseConfig.showMedia ||
        message.isVideo && !firebaseConfig.showMedia) return;

    final index = chatLengt;
    _messages.add(message);
    chatListKey.currentState?.insertItem(index);
    // _chatListKey.currentState?.insertItem(index);
    playIncomingMessageRingtone();
    scrollDown();
  }

  // ================================================
  // CHAT GPT BOT
  // ================================================

  Future<void> createThread() async {
    final thread = await openAI.threads.createThread(request: ThreadRequest());
    threadId = thread.id;
    notifyListeners();
  }

  Future<void> sendMessageToGPT(
      {String? customValue, bool isBot = false}) async {
    final text = _textController.text.trim();
    // check text & custom val
    if (text.isEmpty && customValue == null) {
      _textController.clear();
      notifyListeners();
      return;
    }
    // create message
    final message = _createMessage(customValue ?? text, isBot: isBot);
    // create message in thread
    _textController.clear();
    showSendButton = false;
    showLoader(true);
    await _createMessageInThread(message.content, false);
    if (customValue == null) {
      // add user message to ui
      _addNewMessage(message);
      // start run
      final incomingText = await _startBotRun();
      if (incomingText == null) return;
      final incomingMessage = _createMessage(incomingText, isBot: true);
      _addNewMessage(incomingMessage);
      showLoader(false);
    }
  }

  Future<void> _createMessageInThread(String value, bool isBot) async {
    await openAI.threads.messages.createMessage(
      threadId: threadId,
      request: CreateMessage(
        role: isBot ? 'assistant' : 'user',
        content: value,
      ),
    );
  }

  Future<String?> _startBotRun() async {
    final run = await openAI.threads.runs.createRun(
      threadId: threadId,
      request: CreateRun(assistantId: assistantId),
    );
    runId = run.id;
    status = run.status;

    while (status != "completed") {
      final retrived = await openAI.threads.runs.retrieveRun(
        threadId: threadId,
        runId: runId,
      );
      status = retrived.status;
      runId = retrived.id;
      threadId = retrived.threadId;
      print('status: $status');
    }

    final messages = await openAI.threads.messages.listMessage(
      threadId: threadId,
    );

    final lastMessageInThred = messages.data[0].content[0].text?.value;
    // log('=======================');
    log('LAST MESSAGE: $lastMessageInThred');
    return lastMessageInThred;
  }

  // ================================================
  // ELSE
  // ================================================

  IChatMessage _createMessage(
    String content, {
    bool isPremium = false,
    String type = 'text',
    bool isBot = false,
  }) {
    return IChatMessage(
      date: DateTime.now(),
      isPremiumContent: isPremium,
      type: type,
      isBot: isBot,
      content: content,
    );
  }

  Future<void> scrollDown({bool needDelayed = true}) async {
    await Future.delayed(const Duration(milliseconds: 350));
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 450),
      curve: Curves.linearToEaseOut,
    );
  }

  Future<void> playIncomingMessageRingtone() async {
    await _player.play(
      AssetSource('new_message.mp3'),
      mode: PlayerMode.lowLatency,
    );
  }

  void onChangeFocusListener() {
    isHasFocus = _node.hasFocus;
    notifyListeners();
    if (isHasFocus) {
      scrollDown(needDelayed: false);
      _chatScriptProvider.showScriptBox(false);
    }
    // log('isHasFocus: $isHasFocus');
  }

  void onChangeTextValue(String value) {
    if (value.trim().isNotEmpty) {
      showSendButton = true;
    } else {
      showSendButton = false;
    }
    notifyListeners();
  }

  void showLoader(bool val) {
    isLoading = val;
    notifyListeners();
  }
}
