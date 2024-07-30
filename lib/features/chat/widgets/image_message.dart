import 'package:ai_friend/domain/entity/i_chat_message/i_chat_message.dart';
import 'package:ai_friend/domain/firebase/fire_storage.dart';
import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
import 'package:ai_friend/domain/services/locator.dart';
import 'package:ai_friend/features/assistants/assistants_provider.dart';
import 'package:ai_friend/widgets/blur_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

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

  final firebaseProvider = locator<FireStorage>();
  IChatMessage get message => widget.message;
  bool get isPreview => widget.isPreview!;

  String? url;
  ImageStream? _imageStream;
  ImageProvider<Object>? _imageProvider;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void dispose() {
    _imageStream?.removeListener(ImageStreamListener(_updateImage));
    super.dispose();
  }

  void _loadImage() async {
    if (message.mediaData != null) return;
    final src =
        context.read<AssistantsProvider>().currentAssistant!.chatImagesSrc;
    if (widget.message.mediaData != null) return;
    url = await locator<FireStorage>().getMediaUrl(src, message);
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isPreview ? 10 : 0),
        color: isPreview ? const Color(0xff423556) : Colors.transparent,
      ),
      height: 400,
      child: Center(
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
                          FirebaseAnaliticsService.logOnTapToMessageI();
                          SwipeImageGallery(
                            context: context,
                            initialIndex: 0,
                            transitionDuration: 300,
                            dismissDragDistance: 100,
                            backgroundOpacity: 0.95,
                            children: [
                              ImageMessage(
                                  message: widget.message, isPreview: false)
                            ],
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
                      const BlurWidget(),
                    ],
                  ),
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
      ),
    );
  }
}
