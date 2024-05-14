// ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'package:flutter/cupertino.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppButton extends StatefulWidget {
  final String title;
  final SvgPicture? icon;
  final GestureTapCallback onTap;
  final bool? isDisabled;

  const AppButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.isDisabled = false,
    this.icon,
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: double.infinity,
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(-0.71, 0.71),
                end: Alignment(0.71, -0.71),
                colors: [Color(0xFFBB3DA0), Color(0xFFA762EA)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x7FA762EA),
                  blurRadius: 15,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.icon != null) widget.icon!,
                if (widget.icon != null) const SizedBox(width: 7),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Color(0xFFFBFBFB),
                    fontSize: 16,
                    fontFamily: FontFamily.gothamPro,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            ignoring: !widget.isDisabled!,
            child: AnimatedOpacity(
              curve: Curves.ease,
              duration: const Duration(milliseconds: 500),
              opacity: widget.isDisabled! ? 1 : 0,
              child: Container(
                decoration: ShapeDecoration(
                  color: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
