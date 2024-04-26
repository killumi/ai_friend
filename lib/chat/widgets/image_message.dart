import 'package:ai_friend/chat/chat_storage.dart';
import 'package:ai_friend/chat/widgets/video_message.dart';
import 'package:ai_friend/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/firebase/fire_storage.dart';
import 'package:ai_friend/gen/assets.gen.dart';
import 'package:ai_friend/locator.dart';
import 'package:ai_friend/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';
import 'package:pro_animated_blur/pro_animated_blur.dart';

class ImageMessage extends StatefulWidget {
  final IChatMessage message;
  final bool? isPreview;
  const ImageMessage({required this.message, this.isPreview = true, super.key});

  @override
  State<ImageMessage> createState() => _ImageMessageState();
}

class _ImageMessageState extends State<ImageMessage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final firebaseProvider = locator<FireStorageProvider>();
  IChatMessage get message => widget.message;
  bool get isPreview => widget.isPreview!;

  String? url;
  ImageStream? _imageStream;
  ImageProvider<Object>? _imageProvider;
  bool _isBlurred = true;

  @override
  void initState() {
    super.initState();
    _isBlurred = isPreview;
    _loadImage();
  }

  @override
  void dispose() {
    _imageStream?.removeListener(ImageStreamListener(_updateImage));
    super.dispose();
  }

  void toggleBlur() {
    _isBlurred = !_isBlurred;
    setState(() {});
  }

  void _loadImage() async {
    if (widget.message.mediaData != null) return;
    url = await locator<FireStorageProvider>().getMediaUrl(message);
    final imageStreamProvider = NetworkImage(url!);
    _imageStream = imageStreamProvider.resolve(ImageConfiguration.empty);
    _imageStream?.addListener(ImageStreamListener(_updateImage));
  }

  void _updateImage(ImageInfo info, bool synchronousCall) {
    if (mounted) {
      if (url == null) return;
      setState(() {
        _imageProvider = NetworkImage(url!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.only(bottom: isPreview ? 10 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isPreview ? 10 : 0),
        color: isPreview ? const Color(0xff423556) : Colors.black,
      ),
      height: 400,
      child: _imageProvider != null || widget.message.mediaData != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(isPreview ? 10 : 0),
              child: AspectRatio(
                  aspectRatio: 9 / 13,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!isPreview) return;
                          final images = locator<ChatStorage>().media;
                          final index = images.indexOf(message);
                          SwipeImageGallery(
                            context: context,
                            initialIndex:
                                index == -1 ? images.length - 1 : index,
                            transitionDuration: 300,
                            dismissDragDistance: 100,
                            backgroundOpacity: 0.95,
                            children: images
                                .map((e) => e.isImage
                                    ? ImageMessage(message: e, isPreview: false)
                                    : Center(
                                        child: VideoMessage(
                                            message: e, isPreview: false)))
                                .toList(),
                            onSwipe: (index) {},
                          ).show();
                        },
                        child: widget.message.mediaData != null
                            ? Image.memory(
                                widget.message.mediaData!,
                                fit: isPreview ? BoxFit.cover : BoxFit.fitWidth,
                              )
                            : Image(
                                image: _imageProvider!,
                                fit: isPreview ? BoxFit.cover : BoxFit.fitWidth,
                              ),
                      ),
                      // widget.message.mediaData != null
                      //     ? Image.memory(
                      //         widget.message.mediaData!,
                      //         fit: isPreview ? BoxFit.cover : BoxFit.fitWidth,
                      //       )
                      //     : Image(
                      //         image: _imageProvider!,
                      //         fit: isPreview ? BoxFit.cover : BoxFit.fitWidth,
                      //       ),
                      Positioned.fill(
                        child: IgnorePointer(
                          ignoring: !_isBlurred,
                          child: ProAnimatedBlur(
                            blur: _isBlurred ? 15 : 0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.ease,
                            child: GestureDetector(
                                onTap: () => toggleBlur(),
                                child: Container(
                                  color: Colors.transparent,
                                  child: Center(
                                    child: AnimatedOpacity(
                                      opacity: _isBlurred ? 1 : 0,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.ease,
                                      child: SizedBox(
                                        height: 40,
                                        width: 120,
                                        child: AppButton(
                                          title: 'Unblur',
                                          icon: Assets.icons.proIcon
                                              .svg(width: 23),
                                          onTap: () => toggleBlur(),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      )
                    ],
                  )

                  // widget.message.mediaData != null
                  //     ? Image.memory(
                  //         widget.message.mediaData!,
                  //         fit: isPreview ? BoxFit.cover : BoxFit.fitWidth,
                  //       )
                  //     : Image(
                  //         image: _imageProvider!,
                  //         fit: isPreview ? BoxFit.cover : BoxFit.fitWidth,
                  //       ),

                  ),
            )
          : const AspectRatio(
              aspectRatio: 9 / 13,
              child: Center(
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 18,
                ),
              ),
            ),
    );
  }
}
