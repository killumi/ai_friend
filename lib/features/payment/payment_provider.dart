import 'dart:developer';
import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_error.dart';
import 'package:apphud/models/apphud_models/apphud_paywall.dart';
import 'package:apphud/models/apphud_models/apphud_product.dart';
import 'package:flutter/material.dart';

class PaymentProvider with ChangeNotifier {
  bool loading = false;
  ApphudPaywall? _paywall;
  List<ApphudProduct> _products = [];
  Map<String, dynamic> jsonData = {};

  bool _isHasPremium = true;
  bool get isHasPremium => _isHasPremium;

  // List<ApphudProduct> get products => _products;

  // static Future<void> startApphud() async {
  //   await Apphud.start(apiKey: 'app_eaFkt513w8auHVWLMfUuTiprwy6KT1');
  // }

  // String getPrice() {
  //   if (_products.isEmpty) return 'null';
  //   final subscription = _products.first;
  //   final symbol = subscription.skProduct?.priceLocale.currencySymbol;
  //   return '$symbol${subscription.skProduct?.price ?? 'null'}';
  // }

  // Future<void> productsListener(List<ApphudPaywall> data) async {
  //   try {
  //     await updatePremiumStatus();
  //     _paywall = data.firstWhere((e) => e.identifier == 'full_access');
  //     _products = _paywall?.products ?? [];
  //     jsonData = _paywall?.json ?? {};
  //     Apphud.paywallShown(_paywall!);
  //     // print('$_paywall');
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<bool> subscribe() async {
  //   try {
  //     showLoading(true);
  //     await Apphud.purchase(product: _products.first);
  //     await updatePremiumStatus();
  //     showLoading(false);
  //     if (_isHasPremium) {
  //       FirebaseAnaliticsService.logOnSuccessPayment();
  //     }
  //     return _isHasPremium;
  //   } catch (e) {
  //     FirebaseAnaliticsService.logOnPaymentClose();
  //     showLoading(false);
  //     return _isHasPremium;
  //   }
  // }

  void showLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  // Future<bool> restore() async {
  //   try {
  //     showLoading(true);
  //     await Apphud.restorePurchases();
  //     await updatePremiumStatus();
  //     showLoading(false);
  //     return _isHasPremium;
  //   } catch (e) {
  //     log(e.toString());
  //     showLoading(false);
  //     return _isHasPremium;
  //   }
  // }

  // Future<bool> updatePremiumStatus() async {
  //   try {
  //     final result = await Apphud.hasPremiumAccess();
  //     _isHasPremium = result;
  //     notifyListeners();
  //     return _isHasPremium;
  //   } on ApphudError catch (e) {
  //     log(e.toString());
  //     return _isHasPremium;
  //   }
  // }

  void setFreePremium() {
    _isHasPremium = !_isHasPremium;
    notifyListeners();
  }
}
