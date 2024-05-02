// import 'package:ai_enhancer/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GenderItem extends StatelessWidget {
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const GenderItem({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return Expanded(
      child: Bounce(
        tilt: false,
        onTap: () {
          HapticFeedback.mediumImpact();
          onChanged(value);
        },
        child: Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            gradient: isSelected
                ? const LinearGradient(
                    begin: Alignment(-0.71, 0.71),
                    end: Alignment(0.71, -0.71),
                    colors: [Color(0xFFBB3DA0), Color(0xFFA762EA)],
                  )
                : LinearGradient(
                    begin: const Alignment(1.00, -0.03),
                    end: const Alignment(-1, 0.03),
                    colors: [
                      Colors.white.withOpacity(0.10000000149011612),
                      Colors.white.withOpacity(0.15000000596046448)
                    ],
                  ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: FontFamily.gothamPro,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
