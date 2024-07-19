// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:async';
// import 'dart:math' as math;
// import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
// import 'package:ai_friend/domain/firebase/firebase_config.dart';
// // import 'package:ai_friend/domain/helpers/rate_app_helper.dart';
// import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
// import 'package:ai_friend/features/chat/chat_storage.dart';
// import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
// import 'package:ai_friend/domain/entity/i_script_message/i_script_message.dart';
// import 'package:ai_friend/domain/entity/i_script_message_data/i_script_message_data.dart';
// import 'package:ai_friend/domain/firebase/fire_storage.dart';
// import 'package:ai_friend/features/profile/name/name_storage.dart';
// import 'package:ai_friend/locator.dart';
// import 'package:ai_friend/features/profile/name/name_helper.dart';
// import 'package:ai_friend/main.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:oktoast/oktoast.dart';

// class ChatProvider extends ChangeNotifier {
//   final ChatStorage _storage;
//   final ChatScriptProvider _chatScriptProvider;
//   final List<IChatMessage> _messages = [];
//   final firebaseConfig = locator<FirebaseConfig>();

//   bool isHasFocus = false;
//   bool showSendButton = false;
//   bool isLoading = false;
//   final _scrollController = ScrollController();
//   final _textController = TextEditingController();
//   final _node = FocusNode();
//   GlobalKey<AnimatedListState>? chatListKey;

//   final _player = AudioPlayer();

//   String get apiKey => firebaseConfig.gptKey;
//   String get assistantId => firebaseConfig.gptBotId;

//   List<IChatMessage> get messages => _messages;
//   ScrollController get scrollController => _scrollController;
//   TextEditingController get textController => _textController;
//   FocusNode get node => _node;

//   int get chatLengt => _messages.length;

//   late String threadId;
//   late String runId;
//   late String status;

//   late OpenAI openAI;

//   ChatProvider(this._storage, this._chatScriptProvider);

//   void initOpenAI() {
//     openAI = OpenAI.instance.build(
//       token: apiKey,
//       baseOption: HttpSetup(
//         receiveTimeout: const Duration(seconds: 10),
//         connectTimeout: const Duration(seconds: 10),
//       ),
//       enableLog: true,
//     );
//   }

//   Future<void> initChat() async {
//     final startMessage = IChatMessage(
//       date: DateTime.now(),
//       isPremiumContent: false,
//       type: "text",
//       isBot: true,
//       content: "Hey, I think we should talk more. Let's start?😋",
//     );

//     if (_storage.messages.isEmpty) {
//       await Future.delayed(const Duration(seconds: 2));
//       _addNewMessage(startMessage);
//       _storage.addMessage(startMessage);
//     } else {
//       _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//     }
//   }

//   Future<void> initMessages() async {
//     if (_storage.messages.isNotEmpty) {
//       _messages.addAll(_storage.messages);
//     }
//     notifyListeners();
//   }

//   // ================================================
//   // SCRIPT CHAT
//   // ================================================
//   Future<void> sendMessageGetAnswer(IScriptMessage? message,
//       {IScriptMessageData? messageData}) async {
//     if (message == null && messageData == null) return;
//     showLoader(true);
//     final userMessage = IChatMessage(
//       date: DateTime.now(),
//       isPremiumContent: false,
//       type: "text",
//       isBot: false,
//       content: messageData != null
//           ? textController.text.trim()
//           : message?.text.replaceUserName() ?? '',
//     );

//     _addNewMessage(userMessage);
//     _textController.clear();
//     // sendMessageToGPT(customValue: userMessage.content, isBot: false);
//     // await _storage.addMessage(userMessage);
//     await saveMessageToBox(userMessage);
//     FirebaseAnaliticsService.logOnSendScriptMessage(messages.length);

//     await Future.delayed(const Duration(milliseconds: 1000));
//     final answer = message?.answer ?? messageData?.answer;
//     if (answer == null || answer.isEmpty) {
//       showLoader(false);
//       scrollDown();
//       return;
//     }
//     final random = math.Random();
//     final milliseconds = random.nextInt(3001) + 1850;
//     // print('Delayed for $milliseconds milliseconds');
//     for (var e in answer) {
//       await Future.delayed(Duration(milliseconds: milliseconds));
//       e = e.copyWith(content: e.content.replaceUserName());

//       // saveMessageWithMedia(e);
//       await saveMessageToBox(e);
//       _addNewMessage(e);
//       saveMessageWithMedia(e);
//     }
//     await Future.delayed(const Duration(seconds: 1));
//     showLoader(false);
//     scrollDown();
//   }

//   Future<void> saveMessageWithMedia(IChatMessage e) async {
//     final firebaseProvider = locator<FireStorageProvider>();
//     // final rateAppStorage = locator<RateAppStorage>();

//     Uint8List? data;

//     if (e.isImage && !firebaseConfig.showMedia ||
//         e.isVideo && !firebaseConfig.showMedia) return;

//     if (e.type.contains('video')) {
//       // if (rateAppStorage.show) {
//       //   RateAppHelper.showDialog(navigatorKey.currentContext!);
//       //   await rateAppStorage.hide();
//       // }
//       data = await firebaseProvider.downloadVideo(e.content);
//     }

//     if (e.type.contains('image')) {
//       data = await firebaseProvider.downloadImage(e.content);
//     }

//     e.mediaData = data;
//     await e.save();
//     notifyListeners();
//   }

//   Future<void> saveMessageToBox(IChatMessage message) async {
//     await _storage.addMessage(message);
//   }

//   void _addNewMessage(IChatMessage message) {
//     if (message.isImage && !firebaseConfig.showMedia ||
//         message.isVideo && !firebaseConfig.showMedia) return;

//     final index = chatLengt;
//     _messages.add(message);
//     chatListKey?.currentState?.insertItem(index);
//     playIncomingMessageRingtone();
//     scrollDown();
//   }

//   Future<void> toggleLikeMessage(IChatMessage message) async {
//     HapticFeedback.mediumImpact();
//     message.isLiked = message.isLiked == null ? true : !message.isLiked!;
//     await message.save();
//     notifyListeners();
//   }

//   // ================================================
//   // CHAT GPT BOT
//   // ================================================

//   Future<void> createThread() async {
//     final storage = locator<NameStorage>();
//     final name = storage.name;
//     final message = {"role": "user", "content": "My name is $name!"};
//     final metadata = {'username': name};

//     final thread = await openAI.threads.createThread(
//       request: ThreadRequest(messages: [message], metadata: metadata),
//     );

//     threadId = thread.id;
//     notifyListeners();
//   }

//   Future<void> sendMessageToGPT({
//     String? customValue,
//     bool isBot = false,
//   }) async {
//     final text = _textController.text.trim();
//     // check text & custom val
//     if (text.isEmpty && customValue == null) {
//       _textController.clear();
//       notifyListeners();
//       return;
//     }
//     showLoader(true);
//     // create message
//     final message = _createMessage(customValue ?? text, isBot: isBot);
//     await saveMessageToBox(message);
//     // create message in thread
//     _textController.clear();
//     showSendButton = false;
//     await _createMessageInThread(message.content, false);
//     if (customValue == null) {
//       // add user message to ui
//       _addNewMessage(message);
//       FirebaseAnaliticsService.logOnSendUserMessage(messages.length);
//       // start run
//       final incomingText = await _startBotRun();
//       if (incomingText == null) return;
//       final incomingMessage = _createMessage(incomingText, isBot: true);
//       _addNewMessage(incomingMessage);
//       saveMessageToBox(incomingMessage);
//       showLoader(false);
//     }
//   }

//   Future<void> _createMessageInThread(String value, bool isBot) async {
//     try {
//       await openAI.threads.messages.createMessage(
//         threadId: threadId,
//         request: CreateMessage(
//           role: isBot ? 'assistant' : 'user',
//           content: value,
//         ),
//       );
//     } catch (e) {
//       showLoader(false);
//       showToast(
//         'Something went wrong',
//         textPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         position: ToastPosition.center,
//         duration: const Duration(seconds: 3),
//         backgroundColor: Colors.red,
//         animationCurve: Curves.ease,
//       );
//     }
//   }

//   Future<String?> _startBotRun() async {
//     final run = await openAI.threads.runs.createRun(
//       threadId: threadId,
//       request: CreateRun(assistantId: assistantId),
//     );
//     runId = run.id;
//     status = run.status;

//     while (status != "completed") {
//       final retrived = await openAI.threads.runs.retrieveRun(
//         threadId: threadId,
//         runId: runId,
//       );
//       status = retrived.status;
//       runId = retrived.id;
//       threadId = retrived.threadId;
//       // print('status: $status');
//     }

//     final messages = await openAI.threads.messages.listMessage(
//       threadId: threadId,
//     );

//     final lastMessageInThred = messages.data[0].content[0].text?.value;
//     // log('=======================');
//     // log('LAST MESSAGE: $lastMessageInThred');
//     return lastMessageInThred;
//   }

//   // ================================================
//   // ELSE
//   // ================================================

//   IChatMessage _createMessage(
//     String content, {
//     bool isPremium = false,
//     String type = 'text',
//     bool isBot = false,
//   }) {
//     return IChatMessage(
//       date: DateTime.now(),
//       isPremiumContent: isPremium,
//       type: type,
//       isBot: isBot,
//       content: content,
//     );
//   }

//   Future<void> scrollDown({bool needDelayed = true}) async {
//     await Future.delayed(const Duration(milliseconds: 350));
//     scrollController.animateTo(
//       scrollController.position.maxScrollExtent,
//       duration: const Duration(milliseconds: 450),
//       curve: Curves.linearToEaseOut,
//     );
//   }

//   Future<void> playIncomingMessageRingtone() async {
//     await _player.play(
//       AssetSource('new_message.mp3'),
//       mode: PlayerMode.lowLatency,
//     );
//   }

//   void onChangeFocusListener() {
//     isHasFocus = _node.hasFocus;
//     notifyListeners();
//     if (isHasFocus) {
//       scrollDown(needDelayed: false);
//       _chatScriptProvider.showScriptBox(false);
//     }
//     // log('isHasFocus: $isHasFocus');
//   }

//   void onChangeTextValue(String value) {
//     if (value.trim().isNotEmpty) {
//       showSendButton = true;
//     } else {
//       showSendButton = false;
//     }
//     notifyListeners();
//   }

//   void showLoader(bool val) {
//     isLoading = val;
//     notifyListeners();
//   }
// }

// ======================

import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
import 'package:ai_friend/domain/firebase/firebase_config.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/features/chat/chat_storage.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/domain/entity/i_script_message/i_script_message.dart';
import 'package:ai_friend/domain/entity/i_script_message_data/i_script_message_data.dart';
// import 'package:ai_friend/domain/firebase/fire_storage.dart';
import 'package:ai_friend/features/profile/name/name_helper.dart';
import 'package:ai_friend/features/profile/name/name_storage.dart';
import 'package:ai_friend/locator.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';

class ChatProvider extends ChangeNotifier {
  final firebaseConfig = locator<FirebaseConfig>();
  late GlobalKey<AnimatedListState> chatListKey;

  final ChatStorage _storage;
  final ChatScriptProvider _chatScriptProvider;
  final List<IChatMessage> _messages = [];

  bool isHasFocus = false;
  bool showSendButton = false;
  bool isLoading = false;
  final _scrollController = ScrollController();
  final _textController = TextEditingController();
  final _node = FocusNode();
  // final _player = AudioPlayer();

  String get apiKey => firebaseConfig.gptKey;
  String get assistantId => firebaseConfig.gptBotId;

  List<IChatMessage> get messages => _messages;
  ScrollController get scrollController => _scrollController;
  TextEditingController get textController => _textController;
  FocusNode get node => _node;

  int get chatLength => _messages.length;

  late String threadId;
  late String runId;
  late String status;

  late OpenAI openAI;

  ChatProvider(this._storage, this._chatScriptProvider);

  void initOpenAI() {
    openAI = OpenAI.instance.build(
      token: apiKey,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 10),
        connectTimeout: const Duration(seconds: 10),
      ),
      enableLog: true,
    );
  }

  Future<void> initChat() async {
    notifyListeners();
    final startMessage = IChatMessage(
      date: DateTime.now(),
      isPremiumContent: false,
      type: "text",
      isBot: true,
      content: "Hey, I think we should talk more. Let's start?😋",
    );

    if (_storage.messages.isEmpty) {
      await Future.delayed(const Duration(seconds: 2));
      _addNewMessage(startMessage, needScroll: false);
      _storage.addMessage(startMessage);
    } else {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  Future<void> initMessages() async {
    if (_storage.messages.isNotEmpty) {
      _messages.addAll(_storage.messages);
    }
    notifyListeners();
  }

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
    await saveMessageToBox(userMessage);
    FirebaseAnaliticsService.logOnSendScriptMessage(messages.length);

    await Future.delayed(const Duration(milliseconds: 1000));
    final answer = message?.answer ?? messageData?.answer;
    if (answer == null || answer.isEmpty) {
      showLoader(false);
      scrollDown();
      return;
    }
    final random = math.Random();
    final milliseconds = random.nextInt(3001) + 1850;
    for (var e in answer) {
      await Future.delayed(Duration(milliseconds: milliseconds));
      e = e.copyWith(content: e.content.replaceUserName());
      await saveMessageToBox(e);
      _addNewMessage(e);
      saveMessageWithMedia(e);
    }
    await Future.delayed(const Duration(seconds: 1));
    showLoader(false);
    scrollDown();
  }

  Future<void> saveMessageWithMedia(IChatMessage e) async {
    // final firebaseProvider = locator<FireStorageProvider>();

    Uint8List? data;

    if (e.isImage && !firebaseConfig.showMedia ||
        e.isVideo && !firebaseConfig.showMedia) return;

    // if (e.type.contains('video')) {
    //   data = await firebaseProvider.downloadVideo(e.content);
    // }

    // if (e.type.contains('image')) {
    //   data = await firebaseProvider.downloadImage(e.content);
    // }

    e.mediaData = data;
    await e.save();
    notifyListeners();
  }

  Future<void> saveMessageToBox(IChatMessage message) async {
    await _storage.addMessage(message);
  }

  // void _addNewMessage(IChatMessage message) {
  //   if (message.isImage && !firebaseConfig.showMedia ||
  //       message.isVideo && !firebaseConfig.showMedia) return;

  //   final index = chatLength;
  //   _messages.add(message);
  //   if (chatListKey == null) {
  //     log('====== CHAT LIST KEY IS NULL:$chatListKey');
  //     return;
  //   }
  //   chatListKey?.currentState?.insertItem(index);
  //   playIncomingMessageRingtone();
  //   scrollDown();
  // }

  // void _addNewMessage(IChatMessage message, {bool needScroll = true}) {
  //   final index = _messages.length;
  //   _messages.add(message);
  //   if (chatListKey?.currentState != null) {
  //     chatListKey!.currentState!.insertItem(index);
  //   } else {
  //     log('AnimatedListState is not available.');
  //   }
  //   playIncomingMessageRingtone();
  //   if (needScroll) scrollDown();
  // }

  // void _addNewMessage(IChatMessage message, {bool needScroll = true}) {
  //   final index = _messages.length;
  //   _messages.add(message);
  //   if (chatListKey?.currentState != null) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       chatListKey!.currentState!.insertItem(index);
  //     });
  //   } else {
  //     log('AnimatedListState is not available.');
  //   }
  //   playIncomingMessageRingtone();
  //   scrollDown();
  // }

  void _addNewMessage(IChatMessage message, {bool needScroll = true}) {
    final index = _messages.length;
    _messages.add(message);
    scheduleMicrotask(() {
      if (chatListKey.currentState != null) {
        chatListKey.currentState!.insertItem(index);
      } else {
        log('AnimatedListState is not available.');
      }
    });
    playIncomingMessageRingtone();
    scrollDown();
  }

  Future<void> toggleLikeMessage(IChatMessage message) async {
    HapticFeedback.mediumImpact();
    message.isLiked = message.isLiked == null ? true : !message.isLiked!;
    await message.save();
    notifyListeners();
  }

  Future<void> createThread() async {
    final storage = locator<NameStorage>();
    final name = storage.name;
    final message = {"role": "user", "content": "My name is $name!"};
    final metadata = {'username': name};

    final thread = await openAI.threads.v2.createThread(
      request: ThreadRequest(messages: [message], metadata: metadata),
    );
    threadId = thread.id;
    notifyListeners();
  }

  Future<void> sendMessageToGPT({
    String? customValue,
    bool isBot = false,
  }) async {
    final text = _textController.text.trim();
    if (text.isEmpty && customValue == null) {
      _textController.clear();
      notifyListeners();
      return;
    }
    showLoader(true);
    final message = _createMessage(customValue ?? text, isBot: isBot);
    await saveMessageToBox(message);
    _textController.clear();
    showSendButton = false;
    await _createMessageInThread(message.content, false);
    if (customValue == null) {
      _addNewMessage(message);
      FirebaseAnaliticsService.logOnSendUserMessage(messages.length);
      final incomingText = await _startBotRun();
      if (incomingText == null) return;
      final incomingMessage = _createMessage(incomingText, isBot: true);
      _addNewMessage(incomingMessage);
      saveMessageToBox(incomingMessage);
      showLoader(false);
    }
  }

  Future<void> _createMessageInThread(String value, bool isBot) async {
    try {
      await openAI.threads.v2.messages.createMessage(
        threadId: threadId,
        request: CreateMessage(
          role: isBot ? 'assistant' : 'user',
          content: value,
        ),
      );
    } catch (e) {
      showLoader(false);
      showToast(
        'Something went wrong',
        textPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        position: ToastPosition.center,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        animationCurve: Curves.ease,
      );
    }
  }

  Future<String?> _startBotRun() async {
    try {
      final run = await openAI.threads.runs.createRun(
        threadId: threadId,
        request: CreateRun(assistantId: assistantId),
      );
      runId = run.id;
      status = run.status;

      while (status != "completed") {
        final retrieved = await openAI.threads.runs.retrieveRun(
          threadId: threadId,
          runId: runId,
        );
        status = retrieved.status;
        runId = retrieved.id;
        threadId = retrieved.threadId;
      }

      final messages = await openAI.threads.messages.listMessage(
        threadId: threadId,
      );

      final lastMessageInThread = messages.data[0].content[0].text?.value;
      return lastMessageInThread;
    } catch (e) {
      log('Error in _startBotRun: $e');
      return null;
    }
  }

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
    if (needDelayed) {
      await Future.delayed(const Duration(milliseconds: 350));
    }
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 450),
      curve: Curves.linearToEaseOut,
    );
  }

  Future<void> playIncomingMessageRingtone() async {
    // await _player.play(
    //   AssetSource('new_message.mp3'),
    //   mode: PlayerMode.lowLatency,
    // );
  }

  void onChangeFocusListener() {
    isHasFocus = _node.hasFocus;
    notifyListeners();
    if (isHasFocus) {
      scrollDown(needDelayed: false);
      _chatScriptProvider.showScriptBox(false);
    }
  }

  void onChangeTextValue(String value) {
    showSendButton = value.trim().isNotEmpty;
    notifyListeners();
  }

  void showLoader(bool val) {
    isLoading = val;
    notifyListeners();
  }
}
