import 'package:singular_flutter_sdk/singular.dart';
import 'package:singular_flutter_sdk/singular_config.dart';

class SingularAnalitics {
  static Future<void> init() async {
    SingularConfig config = SingularConfig(
      'newgenapps_e1926a86',
      '00ba4608a33e3392baecd12602bc6d63',
    );

    config.skAdNetworkEnabled = true;
    config.waitForTrackingAuthorizationWithTimeoutInterval = 135;
    Singular.start(config);
    await Future.delayed(const Duration(seconds: 1));
    Singular.event('Ai Friend start event');
  }
}
