// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:ai_friend/domain/services/app_router.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:ai_friend/widgets/gallery_save_button.dart';

class GalleryHeader extends StatelessWidget {
  final double currentIndex;
  final int totalLength;
  final GestureTapCallback onSave;

  const GalleryHeader({
    Key? key,
    required this.currentIndex,
    required this.totalLength,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSmal = MediaQuery.of(context).size.height < 750;

    return Container(
      width: double.infinity,
      height: isSmal ? 90 : 120,
      alignment: Alignment.bottomCenter,
      decoration: const ShapeDecoration(
        color: Color(0xFF170C22),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 72,
                child: Center(
                  child: Text(
                    '${currentIndex.toInt() + 1} of $totalLength',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFFBFBFB),
                      fontSize: 20,
                      fontFamily: FontFamily.gothamPro,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 16,
            child: GestureDetector(
              onTap: () => AppRouter.pop(context),
              child: Container(
                width: 28,
                height: 28,
                decoration: const ShapeDecoration(
                  color: Color(0xFF443C4E),
                  shape: OvalBorder(),
                ),
                child: Center(
                  child: Assets.icons.leftChevron.svg(),
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            child: GallerySaveButton(onTap: onSave),
          ),
        ],
      ),
    );
  }
}
