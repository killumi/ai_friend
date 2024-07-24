import 'package:ai_friend/features/payment/payment_provider.dart';
import 'package:ai_friend/domain/services/locator.dart';
import 'package:apphud/listener/apphud_listener.dart';
import 'package:apphud/models/apphud_models/apphud_non_renewing_purchase.dart';
import 'package:apphud/models/apphud_models/apphud_paywalls.dart';
import 'package:apphud/models/apphud_models/apphud_placement.dart';
import 'package:apphud/models/apphud_models/apphud_subscription.dart';
import 'package:apphud/models/apphud_models/apphud_user.dart';
import 'package:apphud/models/apphud_models/composite/apphud_product_composite.dart';
import 'package:apphud/apphud.dart';

class ApphudPaymentListener implements ApphudListener {
  @override
  Future<void> apphudDidChangeUserID(String userId) async {
    // print('apphudDidChangeUserID: $userId');
  }

  @override
  Future<void> apphudDidFecthProducts(
      List<ApphudProductComposite> products) async {
    // print('apphudDidFecthProducts: $products');
  }

  @override
  Future<void> apphudNonRenewingPurchasesUpdated(
    List<ApphudNonRenewingPurchase> purchases,
  ) async {
    // print('apphudNonRenewingPurchasesUpdated: $purchases');
  }

  @override
  Future<void> apphudSubscriptionsUpdated(
      List<ApphudSubscriptionWrapper> subscriptions) async {
    // print('apphudSubscriptionsUpdated: $subscriptions');
  }

  @override
  Future<void> paywallsDidFullyLoad(ApphudPaywalls data) async {
    // print('paywallsDidFullyLoad: $data');
    locator<PaymentProvider>().productsListener(data.paywalls);
  }

  @override
  Future<void> placementsDidFullyLoad(List<ApphudPlacement> placements) async {
    // print('apphudNonRenewingPurchasesUpdated: $placements');
  }

  @override
  Future<void> userDidLoad(ApphudUser user) async {
    // print('userDidLoad: $userDidLoad');
  }
}
