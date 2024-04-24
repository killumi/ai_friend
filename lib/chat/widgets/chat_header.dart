import 'package:ai_friend/app_router.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatHeader extends StatefulWidget {
  const ChatHeader({super.key});

  @override
  State<ChatHeader> createState() => _ChatHeaderState();
}

class _ChatHeaderState extends State<ChatHeader> {
  bool isShowOptions = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const ShapeDecoration(
            color: Color(0xFF170C22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 47),
              Row(
                children: [
                  SizedBox(
                    width: 96,
                    height: 40,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => print('asd'),
                        child: Container(
                          height: 40,
                          width: 40,
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          child: Assets.icons.settingsIcon.svg(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isShowOptions = !isShowOptions;
                        });
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.images.chatAvatar.image(width: 40),
                            const SizedBox(width: 10),
                            const Text(
                              'Alice',
                              style: TextStyle(
                                color: Color(0xFFFBFBFB),
                                fontSize: 18,
                                fontFamily: FontFamily.gothamPro,
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            const SizedBox(width: 5),
                            !isShowOptions
                                ? Assets.icons.arrowDownIcon.svg()
                                : Assets.icons.arrowUpIcon.svg(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 96,
                    height: 40,
                    child: GestureDetector(
                      onTap: () => print('asd'),
                      child: Container(
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
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.icons.proIcon.svg(),
                            const SizedBox(width: 6),
                            const Text(
                              'PRO',
                              style: TextStyle(
                                color: Color(0xFFFBFBFB),
                                fontSize: 16,
                                fontFamily: FontFamily.gothamPro,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
                height: isShowOptions ? 105 : 0,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {},
                        child: _buildOption(
                          Assets.icons.lipsProfile.svg(),
                          'Alice’s Profile',
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          AppRouter.openGallery(context);
                          setState(() {
                            isShowOptions = !isShowOptions;
                          });
                        },
                        child: _buildOption(
                          Assets.icons.galleryIcon.svg(),
                          'View Gallery',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(SvgPicture icon, String title) {
    return Container(
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.71, 0.71),
                end: Alignment(0.71, -0.71),
                colors: [Color(0xFFBB3DA0), Color(0xFFA762EA)],
              ),
              shape: OvalBorder(),
            ),
            child: Center(child: icon),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFFBFBFB),
              fontSize: 16,
              fontFamily: FontFamily.gothamPro,
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          )
        ],
      ),
    );
  }
}
