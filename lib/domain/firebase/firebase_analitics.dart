import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_attribution_provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnaliticsService {
  static FirebaseAnalytics instance = FirebaseAnalytics.instance;

  static Future<void> init() async {
    final apphudId = await Apphud.userID();
    final appInstanceId = await instance.appInstanceId;
    await instance.setUserId(id: apphudId);

    Apphud.addAttribution(
      data: {},
      provider: ApphudAttributionProvider.firebase,
      identifier: appInstanceId,
    );

    await instance.logAppOpen();
  }

  static Future<void> logOnSendScriptMessage(int index) async {
    await instance.logEvent(
      name: 'on_send_script_message',
      parameters: {'index': '$index'},
    );
  }

  static Future<void> logOnSendUserMessage(int index) async {
    await instance.logEvent(
      name: 'on_send_user_message',
      parameters: {'index': '$index'},
    );
  }

  static Future<void> logOnTapContinueChatingButton() async {
    await instance.logEvent(name: 'on_tap_continue_chating_button');
  }

  static Future<void> logOnSuccessPayment() async {
    await instance.logEvent(name: 'on_success_payment');
  }

  static Future<void> logOnPaymentClose() async {
    await instance.logEvent(name: 'on_payment_close');
  }

  static Future<void> logOnOpenGallery() async {
    await instance.logEvent(name: 'on_open_gallery');
  }

  static Future<void> logOnTapToMessageV() async {
    await instance.logEvent(name: 'on_tap_to_v_message');
  }

  static Future<void> logOnTapToMessageI() async {
    await instance.logEvent(name: 'on_tap_to_i_message');
  }

  static Future<void> logOnLikeMessage() async {
    await instance.logEvent(name: 'on_like_message');
  }

  static Future<void> logOnSaveV() async {
    await instance.logEvent(name: 'on_save_v');
  }

  static Future<void> logOnSaveI() async {
    await instance.logEvent(name: 'on_save_i');
  }

  static Future<void> logOnOpenOnboarding() async {
    await instance.logEvent(name: 'on_open_onboarding');
  }

  static Future<void> logOnLeaveOnboarding() async {
    await instance.logEvent(name: 'on_leave_onboarding');
  }

  static Future<void> logOnOpenChatScreen() async {
    await instance.logEvent(name: 'on_open_chat_screen');
  }

  static Future<void> logOnOpenProfileScreenAfterOnboarding() async {
    await instance.logEvent(name: 'on_open_profile_screen_after_onboarding');
  }

  static Future<void> logOnOpenProfileScreen() async {
    await instance.logEvent(name: 'on_open_profile_screen');
  }
}
