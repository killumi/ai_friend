import 'dart:io';
import 'dart:typed_data';

import 'package:ai_friend/domain/firebase/firebase_analitics.dart';
import 'package:ai_friend/domain/services/app_router.dart';
import 'package:ai_friend/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

class GalleryHelper {
  Future<void> onSaveImage(Uint8List data) async {
    FirebaseAnaliticsService.logOnSaveI();

    final result = await ImageGallerySaver.saveImage(
      data,
      quality: 100,
    );

    if (result["isSuccess"]) {
      showToast(
        'Image was saved',
        textPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        position: ToastPosition.center,
        duration: const Duration(seconds: 3),
        animationCurve: Curves.ease,
      );
    } else {
      showOpenSettingsAlert();
    }
  }

  Future<void> onSaveVideo(File file, String name) async {
    FirebaseAnaliticsService.logOnSaveV();

    final result = await ImageGallerySaver.saveFile(file.path, name: name);

    if (result["isSuccess"]) {
      showToast(
        'Video was saved',
        textPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        position: ToastPosition.center,
        duration: const Duration(seconds: 3),
        animationCurve: Curves.ease,
      );
    } else {
      showOpenSettingsAlert();
    }
  }

  Future<void> requestPermission() async {
    // await Permission.mediaLibrary.request().then((value) async {
    //   final isGranted = await Permission.photos.status.isGranted;
    //   if (!isGranted) {
    //     showOpenSettingsAlert();
    //     return;
    //   }

    // file = await _imagePicker.pickImage(source: ImageSource.gallery);
    // });

    // if (file == null) return null;
    // file = await compressImage(file!);
    // if (file == null) return null;
    // final compressSize = await getFileSizeMb(file!);
    // print('compressSize: $compressSize');
    // final image = await createBaseImage(file!);
  }

  void showOpenSettingsAlert() {
    final context = navigatorKey.currentContext;

    showDialog(
      context: context!,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Permission was Denied'),
          content: const Text(
            'Please go to settings and enable permission to use photo library',
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () => AppRouter.pop(context),
            ),
            CupertinoDialogAction(
              child: const Text('Settings'),
              onPressed: () {
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }
}
