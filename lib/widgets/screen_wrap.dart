import 'package:flutter/material.dart';

class ScreenWrap extends StatelessWidget {
  final Widget child;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;

  const ScreenWrap({
    required this.child,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = false,
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Container(
        constraints: const BoxConstraints.expand(),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.21, -0.98),
            end: Alignment(-0.21, 0.98),
            colors: [Color(0xFF211337), Color(0xFF0F0711)],
          ),
        ),
        child: child,
      ),
    );
  }
}
