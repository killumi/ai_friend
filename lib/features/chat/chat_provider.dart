// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:ai_friend/domain/entity/i_assistant/i_assistant.dart';
import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
import 'package:ai_friend/domain/firebase/firebase_config.dart';
import 'package:ai_friend/domain/helpers/rate_app_helper.dart';
import 'package:ai_friend/features/assistants/assistants_provider.dart';
import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/domain/entity/i_script_message/i_script_message.dart';
import 'package:ai_friend/domain/entity/i_script_message_data/i_script_message_data.dart';
import 'package:ai_friend/domain/firebase/fire_storage.dart';
import 'package:ai_friend/features/chat/chat_script/chat_script_provider.dart';
import 'package:ai_friend/features/profile/name/name_storage.dart';
import 'package:ai_friend/domain/services/locator.dart';
import 'package:ai_friend/features/profile/name/name_helper.dart';
import 'package:ai_friend/main.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';

class ChatProvider extends ChangeNotifier {
  final AssistantsProvider _assistantsProvider;
  final ChatScriptProvider _chatScriptProvider;
  final firebaseConfig = locator<FirebaseConfig>();

  List<IChatMessage> _messages = [];

  bool isHasFocus = false;
  bool showSendButton = false;
  bool isLoading = false;

  late GlobalKey<AnimatedListState> chatListKey;
  late String threadId;
  late String runId;
  late String status;
  late OpenAI openAI;

  final _scrollController = ScrollController();
  final _textController = TextEditingController();
  final _node = FocusNode();
  final _player = AudioPlayer();

  IAssistant get currentAssistant => _assistantsProvider.currentAssistant!;
  List<IChatMessage> get _savedMessages => currentAssistant.messages!;

  String get imageSrc => currentAssistant.chatImagesSrc;
  String get videoSrc => currentAssistant.chatVideosSrc;

  String get apiKey => firebaseConfig.gptKey;
  String get assistantId => currentAssistant.assistantKey;

  List<IChatMessage> get messages => _messages;
  ScrollController get scrollController => _scrollController;
  TextEditingController get textController => _textController;
  FocusNode get node => _node;

  ChatProvider(this._assistantsProvider, this._chatScriptProvider);

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
    isLoading = true;
    notifyListeners();

    _messages = [];
    if (_savedMessages.isEmpty) {
      final startMessage = IChatMessage(
        date: DateTime.now(),
        isPremiumContent: false,
        type: "text",
        isBot: true,
        content: currentAssistant.startMessage,
      );
      _addNewMessageToList(startMessage);
      currentAssistant.messages?.add(startMessage);
      await currentAssistant.save();
    } else {
      for (var message in _savedMessages) {
        await _addNewMessageToList(message, animated: false);
      }
    }
    isLoading = false;
    notifyListeners();
  }

  // Future<void> initChat() async {
  //   isLoading = true;
  //   notifyListeners();

  //   _messages = [];
  //   if (_savedMessages.isEmpty) {
  //     final startMessage = IChatMessage(
  //       date: DateTime.now(),
  //       isPremiumContent: false,
  //       type: "text",
  //       isBot: true,
  //       content: currentAssistant.startMessage,
  //     );
  //     await _addNewMessageToList(startMessage);
  //     currentAssistant.messages?.add(startMessage);
  //     await currentAssistant.save();
  //   } else {
  //     for (var message in _savedMessages) {
  //       await _addNewMessageToList(message, animated: false);
  //     }
  //   }
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   isLoading = false;
  //   notifyListeners();
  // }

  Future<void> _addNewMessageToList(
    IChatMessage message, {
    bool animated = true,
  }) async {
    final index = _messages.length;
    _messages.add(message);
    notifyListeners();
    if (animated) {
      chatListKey.currentState?.insertItem(index);
    }

    await scrollDown(animate: animated);
    // notifyListeners();
  }

  Future<void> scrollDown({bool animate = true, bool min = false}) async {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      if (min) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      } else {
        if (!animate) {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.extentTotal);
          }
          return;
        } else {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
      }
    });
  }

  // ================================================
  // SCRIPT CHAT
  // ================================================
  Future<void> sendMessageGetAnswer(
    IScriptMessage? message, {
    IScriptMessageData? messageData,
  }) async {
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
    await Future.delayed(const Duration(milliseconds: 550));
    _addNewMessageToList(userMessage);
    _textController.clear();
    playIncomingMessageRingtone();
    await saveMessageToBox(userMessage);
    FirebaseAnaliticsService.logOnSendScriptMessage(messages.length);

    await Future.delayed(const Duration(milliseconds: 400));
    final answer = message?.answer ?? messageData?.answer;
    if (answer == null || answer.isEmpty) {
      showLoader(false);
      await Future.delayed(const Duration(milliseconds: 650));
      scrollDown();
      return;
    }
    final random = math.Random();
    final milliseconds = random.nextInt(2001) + 1450;
    // final milliseconds = 350;
    for (var e in answer) {
      await Future.delayed(Duration(milliseconds: milliseconds));
      e = e.copyWith(content: e.content.replaceUserName());
      await saveMessageToBox(e);
      final updatedMessage = await saveMessageWithMedia(e);
      _addNewMessageToList(updatedMessage ?? e);
      playIncomingMessageRingtone();
    }
    // await Future.delayed(const Duration(seconds: 1));
    await Future.delayed(const Duration(milliseconds: 500));
    showLoader(false);
    await Future.delayed(const Duration(milliseconds: 500));
    scrollDown();
  }

  Future<IChatMessage?> saveMessageWithMedia(IChatMessage e) async {
    final firebaseProvider = locator<FireStorage>();
    final rateAppStorage = locator<RateAppStorage>();

    Uint8List? data;

    final index = currentAssistant.messages!.indexOf(e);
    // log('INDEX VIDEO OR IMAGE MESSAGE: $index , ${e.type}, ${e.content}');

    if (e.isImage && !firebaseConfig.showMedia ||
        e.isVideo && !firebaseConfig.showMedia) return null;

    if (e.type.contains('video')) {
      if (rateAppStorage.show) {
        RateAppHelper.showDialog(navigatorKey.currentContext!);
        await rateAppStorage.hide();
      }
      data = await firebaseProvider.downloadVideo(videoSrc, e.content);
    }

    if (e.type.contains('image')) {
      data = await firebaseProvider.downloadImage(imageSrc, e.content);
    }

    e.mediaData = data;
    currentAssistant.messages![index] = e;
    await currentAssistant.save();
    return e;
  }

  Future<void> saveMessageToBox(IChatMessage message) async {
    currentAssistant.messages!.add(message);
    await currentAssistant.save();
  }

  Future<void> toggleLikeMessage(IChatMessage message) async {
    HapticFeedback.mediumImpact();
    final index = currentAssistant.messages!.indexOf(message);
    message.isLiked = message.isLiked == null ? true : !message.isLiked!;
    currentAssistant.messages![index] = message;
    await currentAssistant.save();
    messages[index] = message;
    notifyListeners();
  }

  // ================================================
  // CHAT GPT BOT
  // ================================================

  Future<void> createThread() async {
    threadId = '';
    runId = '';
    status = '';
    final storage = locator<NameStorage>();
    final name = storage.name;
    final message = {"role": "user", "content": "My name is $name!"};
    final metadata = {'username': name};
    try {
      final thread = await openAI.threads.v2.createThread(
        request: ThreadRequest(messages: [message], metadata: metadata),
      );
      threadId = thread.id;
      notifyListeners();
    } catch (e) {
      log('ERROR CREATE THREAD: $e');
    }
  }

  Future<void> sendMessageToGPT({
    String? customValue,
    bool isBot = false,
  }) async {
    final text = _textController.text.trim();
    // check text & custom val
    if (text.isEmpty && customValue == null) {
      _textController.clear();
      notifyListeners();
      return;
    }
    showLoader(true);
    // create message
    final message = _createMessage(customValue ?? text, isBot: isBot);
    await saveMessageToBox(message);
    // create message in thread
    _textController.clear();
    showSendButton = false;
    await _createMessageInThread(message.content, false);
    playIncomingMessageRingtone();
    if (customValue == null) {
      // add user message to ui
      _addNewMessageToList(message);
      FirebaseAnaliticsService.logOnSendUserMessage(messages.length);
      // start run
      final incomingText = await _startBotRun();
      if (incomingText == null) return;
      final incomingMessage = _createMessage(incomingText, isBot: true);
      playIncomingMessageRingtone();
      _addNewMessageToList(incomingMessage);

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
      final run = await openAI.threads.v2.runs.createRun(
        threadId: threadId,
        request: CreateRun(assistantId: assistantId),
      );
      runId = run.id;
      status = run.status;

      while (status != "completed" && status != "failed") {
        final retrieved = await openAI.threads.runs.retrieveRun(
          threadId: threadId,
          runId: runId,
        );
        status = retrieved.status;
        runId = retrieved.id;
        threadId = retrieved.threadId;
        // print('status: $status');
        await Future.delayed(const Duration(seconds: 1));
      }

      if (status == 'failed') {
        print('GPT ERROR: $status');
        return null;
      }

      final messages = await openAI.threads.v2.messages.listMessage(
        threadId: threadId,
      );

      final lastMessageInThread = messages.data[0].content[0].text.value;
      // log('LAST MESSAGE: $lastMessageInThread');
      return lastMessageInThread;
    } catch (e) {
      final errorMessage = IChatMessage(
        date: DateTime.now(),
        isBot: true,
        type: 'text',
        content: 'Error: ${e.toString()}',
        isPremiumContent: false,
      );

      _addNewMessageToList(errorMessage);
      return null;
    }
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

  Future<void> playIncomingMessageRingtone() async {
    await _player.play(
      AssetSource('new_message.mp3'),
      mode: PlayerMode.lowLatency,
    );
  }

  void onChangeFocusListener() async {
    isHasFocus = _node.hasFocus;
    notifyListeners();
    if (isHasFocus) {
      _chatScriptProvider.expandScriptBox(false);
      await Future.delayed(const Duration(milliseconds: 300));
      scrollDown();
    }
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
