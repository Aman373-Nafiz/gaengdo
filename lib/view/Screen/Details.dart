import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gaengdo/data/services/photo_controller_service.dart';
import 'package:gaengdo/resources/color.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

class Details extends StatelessWidget {
  final String imageURL;

  Details({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    final Photos = Get.put(PhotoController());
    if (imageURL == null || imageURL!.isEmpty) {
      return Scaffold(
        backgroundColor: BgColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Photo View',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
        ),
        body: Center(
          child: Text(
            'Image URL is unavailable.',
            style: GoogleFonts.roboto(
              color: Colors.black54,
              fontSize: 18,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: BgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Photo View',
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () async {
              try {
                await Photos.savePhoto(imageURL);
                Get.snackbar("Success", "Picture saved successfully.");
              } catch (e) {
                Get.snackbar("Error", "Failed to save the picture.");
                print(e);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              try {
                await Photos.ShareImage(imageURL);
              } catch (e) {
                Get.snackbar("Error", "Failed to share the picture.");
                print(e);
              }
            },
          ),
        ],
      ),
      body: PhotoView(
        imageProvider: CachedNetworkImageProvider(imageURL!),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 3,
        initialScale: PhotoViewComputedScale.contained,
        enableRotation: true,
        gestureDetectorBehavior: HitTestBehavior.deferToChild,
        errorBuilder: (context, error, stackTrace) => Center(
          child: Icon(
            Icons.error,
            size: 40,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
