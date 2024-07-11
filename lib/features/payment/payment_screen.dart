// // ignore_for_file: use_build_context_synchronously

// import 'package:ai_friend/app_router.dart';
// import 'package:ai_friend/domain/firebase/firebase_config.dart';
// import 'package:ai_friend/features/chat/chat_provider.dart';
// import 'package:ai_friend/features/payment/payment_provider.dart';
// import 'package:ai_friend/gen/assets.gen.dart';
// import 'package:ai_friend/gen/fonts.gen.dart';
// import 'package:ai_friend/locator.dart';
// import 'package:ai_friend/widgets/pulse_button.dart';
// import 'package:ai_friend/widgets/screen_wrap.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({super.key});

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   bool get showMedia => locator<FirebaseConfig>().showMedia;

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<PaymentProvider>();
//     final price = provider.getPrice();
//     final isSmal = MediaQuery.of(context).size.height < 750;

//     return Stack(
//       children: [
//         ScreenWrap(
//           child: SafeArea(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Column(
//                   children: [
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: Stack(
//                         fit: StackFit.loose,
//                         alignment: Alignment.center,
//                         clipBehavior: Clip.none,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 30),
//                             child: AspectRatio(
//                               aspectRatio: isSmal ? 1 / 1 : 1 / 1.2,
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     image: Assets.images.paywall.provider(),
//                                     fit: isSmal
//                                         ? BoxFit.contain
//                                         : BoxFit.fitWidth,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const Positioned(
//                             bottom: -20,
//                             child: Text(
//                               'Immerse into deeper\nconnection with Alice',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Color(0xFFFBFBFB),
//                                 fontSize: 28,
//                                 fontFamily: FontFamily.gothamPro,
//                                 fontWeight: FontWeight.w700,
//                                 height: 1.3,
//                                 shadows: <Shadow>[
//                                   Shadow(
//                                     offset: Offset(0.0, 0.0),
//                                     blurRadius: 13.0,
//                                     color: Color(0xFFFBFBFB),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 50),
//                     SizedBox(
//                       width: 230,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Assets.icons.paywallIcon1.image(width: 24),
//                           const SizedBox(width: 6),
//                           const Text(
//                             'Chat without limits',
//                             style: TextStyle(
//                               color: Color(0xFFFBFBFB),
//                               fontSize: 16,
//                               fontFamily: 'Gotham Pro',
//                               fontWeight: FontWeight.w600,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     if (showMedia) const SizedBox(height: 6),
//                     if (showMedia)
//                       SizedBox(
//                         width: 230,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Assets.icons.paywallIcon2.image(width: 24),
//                             const SizedBox(width: 6),
//                             const Text(
//                               'More photos & videos',
//                               style: TextStyle(
//                                 color: Color(0xFFFBFBFB),
//                                 fontSize: 16,
//                                 fontFamily: 'Gotham Pro',
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     const SizedBox(height: 6),
//                     SizedBox(
//                       width: 230,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Assets.icons.paywallIcon3.image(width: 24),
//                           const SizedBox(width: 6),
//                           const Text(
//                             'Discussion of any topics',
//                             style: TextStyle(
//                               color: Color(0xFFFBFBFB),
//                               fontSize: 16,
//                               fontFamily: 'Gotham Pro',
//                               fontWeight: FontWeight.w600,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 30),
//                 Opacity(
//                   opacity: 0.70,
//                   child: Text(
//                     'Just $price/week',
//                     style: const TextStyle(
//                       color: Color(0xFFFBFBFB),
//                       fontSize: 16,
//                       fontFamily: FontFamily.gothamPro,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Opacity(
//                   opacity: 0.40,
//                   child: Text(
//                     'No commitment. Cancel anytime',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Color(0xFFFBFBFB),
//                       fontSize: 14,
//                       fontFamily: FontFamily.gothamPro,
//                       fontWeight: FontWeight.w400,
//                       height: 0,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Center(
//                     child: PulseButton(
//                       title: 'Get Started',
//                       onTap: () async {
//                         await subscribe();
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         launchUrl(
//                           Uri.parse(
//                               'https://doc-hosting.flycricket.io/ai-girlfriend-friendly-chat-terms-of-use/47ace2aa-8536-4d16-9f8c-01af0a7717e2/terms'),
//                         );
//                       },
//                       child: const Text(
//                         'Terms of Service',
//                         style: TextStyle(
//                           color: Color(0xFFFBFBFB),
//                           fontSize: 14,
//                           fontFamily: FontFamily.sFPro,
//                           fontWeight: FontWeight.w400,
//                           decoration: TextDecoration.underline,
//                           decorationColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     GestureDetector(
//                       onTap: () {
//                         launchUrl(
//                           Uri.parse(
//                               'https://doc-hosting.flycricket.io/ai-girlfriend-friendly-chat-privacy-policy/98d20278-4947-48cb-9493-09ebeec0e9e7/privacy'),
//                         );
//                       },
//                       child: const Text(
//                         'Privacy Policy',
//                         style: TextStyle(
//                           color: Color(0xFFFBFBFB),
//                           fontSize: 14,
//                           fontFamily: FontFamily.sFPro,
//                           fontWeight: FontWeight.w400,
//                           decoration: TextDecoration.underline,
//                           decorationColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           left: 0,
//           right: 0,
//           top: isSmal ? 20 : 45,
//           child: Material(
//             color: Colors.transparent,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () async {
//                       final result = await provider.restore();
//                       if (!result) return;
//                       AppRouter.openChat(context, removeRoutes: true);
//                     },
//                     child: const Text(
//                       'Restore Purchase',
//                       style: TextStyle(fontSize: 14, color: Colors.white54),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () => closeScreen(),
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       color: Colors.transparent,
//                       alignment: Alignment.center,
//                       child: const Icon(
//                         CupertinoIcons.clear,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Positioned.fill(
//           child: IgnorePointer(
//             ignoring: !provider.loading,
//             child: AnimatedOpacity(
//               opacity: provider.loading ? 1 : 0,
//               duration: const Duration(milliseconds: 750),
//               curve: Curves.ease,
//               child: Container(
//                 color: Colors.black87,
//                 child: const Center(
//                   child: CupertinoActivityIndicator(
//                     color: Colors.white,
//                     radius: 13,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }

//   Future<void> subscribe() async {
//     final result = await context.read<PaymentProvider>().subscribe();
//     if (!result) return;
//     context.read<ChatProvider>().chatListKey = GlobalKey<AnimatedListState>();
//     await Future.delayed(const Duration(milliseconds: 200));
//     AppRouter.openChat(context, removeRoutes: true);
//   }

//   void closeScreen() {
//     if (Navigator.canPop(context)) {
//       AppRouter.pop(context);
//       return;
//     }

//     AppRouter.openChat(context);
//   }
// }
