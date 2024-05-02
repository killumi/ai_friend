// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ai_friend/features/onboarding/onboarding_storage.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

enum OnboardingStep { first, second, third, fourth, fifth, end }

class OnboardingMessage {
  final String? text;
  final String? videoAsset;
  final bool isBot;

  OnboardingMessage({
    this.text,
    this.videoAsset,
    required this.isBot,
  });
}

class OnboardingProvider extends ChangeNotifier {
  final OnboardingStorage _storage;
  OnboardingStep? _currentStep;

  OnboardingProvider(this._storage);

  final _listKeyOnboarding = GlobalKey<AnimatedListState>(debugLabel: '1');
  final _player = AudioPlayer();
  final _scrollController = ScrollController();
  final List<OnboardingMessage> _items = [];

  List<OnboardingMessage> get messages => _items;
  GlobalKey<AnimatedListState> get listKey => _listKeyOnboarding;
  ScrollController get scrollController => _scrollController;

  OnboardingStep? get currentStep => _currentStep;
  bool get isSecondStep => _currentStep == OnboardingStep.second;
  bool get isFourthStep => _currentStep == OnboardingStep.fourth;
  bool get isLastStep => _currentStep == OnboardingStep.end;

  void scrollDown() async {
    await Future.delayed(const Duration(milliseconds: 500));
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 350),
      curve: Curves.ease,
    );
  }

  Future<void> nextStep() async {
    if (currentStep == null) {
      _currentStep = OnboardingStep.first;
    }
    switch (_currentStep) {
      case OnboardingStep.first:
        await _step1();
        return;
      case OnboardingStep.second:
        await _step2();
        return;
      case OnboardingStep.third:
        await _step3();
        return;
      case OnboardingStep.fourth:
        await _step4();
        return;
      case OnboardingStep.fifth:
        await _step5();
        return;
      case OnboardingStep.end:
        await _end();

        return;
      default:
    }
  }

  // ==========================
  Future<void> _step1() async {
    final message = OnboardingMessage(
      text: 'Hello, darling.\nWelcome to AI Girlfriend. Do you want to chat?',
      isBot: true,
    );
    final videoMessage = OnboardingMessage(
      videoAsset: Assets.introVideos.onboarding1,
      isBot: true,
    );

    await _addMessage(message);
    scrollDown();
    await _addMessage(videoMessage);
    scrollDown();
    await Future.delayed(const Duration(milliseconds: 1200));
    _currentStep = OnboardingStep.second;
    notifyListeners();
  }

  Future<void> _step2() async {
    _currentStep = null;
    notifyListeners();
    final message = OnboardingMessage(
      text: 'Yes',
      isBot: false,
    );
    await _addMessage(message);
    scrollDown();
    await Future.delayed(const Duration(milliseconds: 1200));
    _currentStep = OnboardingStep.third;
    notifyListeners();
    nextStep();
  }

  Future<void> _step3() async {
    final message = OnboardingMessage(
      text:
          'Good to hear. Here, you can have unlimited conversations with your AI girlfriend, discussing any topic you want, and openly and safely express your emotions and secret desires.',
      isBot: true,
    );
    final videoMessage = OnboardingMessage(
      videoAsset: Assets.introVideos.onboarding2,
      isBot: true,
    );

    await _addMessage(message);
    scrollDown();
    await _addMessage(videoMessage);
    scrollDown();
    await Future.delayed(const Duration(milliseconds: 1200));
    _currentStep = OnboardingStep.fourth;
    notifyListeners();
  }

  Future<void> _step4() async {
    _currentStep = null;
    notifyListeners();
    final message = OnboardingMessage(
      text: 'Sounds Good!',
      isBot: false,
    );
    await _addMessage(message);
    scrollDown();
    await Future.delayed(const Duration(milliseconds: 1200));
    _currentStep = OnboardingStep.fifth;
    notifyListeners();
    nextStep();
  }

  Future<void> _step5() async {
    final message = OnboardingMessage(
      text:
          "I'd like to get to know you better. Fill in your information on the next screens, so I can keep it in mind during our conversations",
      isBot: true,
    );
    final videoMessage = OnboardingMessage(
      videoAsset: Assets.introVideos.onboarding3,
      isBot: true,
    );

    await _addMessage(message);
    scrollDown();
    await _addMessage(videoMessage);
    scrollDown();
    await Future.delayed(const Duration(milliseconds: 1200));
    _currentStep = OnboardingStep.end;
    notifyListeners();
  }

  Future<void> _end() async {
    // _currentStep = null;
    // notifyListeners();
    await _storage.hideToNextLaunch();
  }

  Future<void> _addMessage(OnboardingMessage message) async {
    if (message.isBot) await Future.delayed(const Duration(milliseconds: 1200));
    final newIndex = _items.length;
    _items.add(message);
    _listKeyOnboarding.currentState!.insertItem(newIndex);
    if (message.isBot) {
      await _player.play(
        AssetSource('new_message.mp3'),
        mode: PlayerMode.lowLatency,
      );
    }
  }
}
