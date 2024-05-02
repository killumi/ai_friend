import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/features/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scroll_datetime_picker/scroll_datetime_picker.dart';

class BirthDateWidget extends StatefulWidget {
  const BirthDateWidget({super.key});

  @override
  State<BirthDateWidget> createState() => _BirthDateWidgetState();
}

class _BirthDateWidgetState extends State<BirthDateWidget> {
  @override
  Widget build(BuildContext context) {
    final profileProvider = context.read<ProfileProvider>();
    final birhtDate = context.select((ProfileProvider e) => e.birhtDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Date of Birth',
          style: TextStyle(
            fontFamily: FontFamily.gothamPro,
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        ScrollDateTimePicker(
          itemExtent: 55,
          wheelOption: const DateTimePickerWheelOption(
            diameterRatio: 5,
            squeeze: 1.0,
            offAxisFraction: 0.4,
            physics: BouncingScrollPhysics(),
          ),
          itemBuilder: (context, pattern, text, isActive, isDisabled) => Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white54,
              fontSize: 24,
              fontFamily: FontFamily.gothamPro,
              height: 0,
              fontWeight: FontWeight.w600,
            ),
          ),
          onChange: profileProvider.onChangeBirthDate,
          dateOption: DateTimePickerOption(
            dateFormat: DateFormat('ddMMMyyyy'),
            minDate: DateTime(
              DateTime.now().year - 50,
              DateTime.now().month,
              DateTime.now().day,
            ).toLocal(),
            maxDate: DateTime(
              DateTime.now().year - 18,
              DateTime.now().month,
              DateTime.now().day,
            ).toLocal(),
            initialDate: birhtDate,
          ),
          centerWidget: DateTimePickerCenterWidget(
            builder: (context, constraints, child) => DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: const Alignment(1.00, -0.03),
                  end: const Alignment(-1, 0.03),
                  colors: [
                    Colors.white.withOpacity(0.10000000149011612),
                    Colors.white.withOpacity(0.15000000596046448)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
