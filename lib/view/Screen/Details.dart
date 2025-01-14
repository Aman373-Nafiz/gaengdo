import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gaengdo/data/services/photo_controller_service.dart';
import 'package:gaengdo/resources/color.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

class Details extends StatelessWidget {
  var imageURL;
  Details({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    var Photos = Get.put(PhotoController());

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: BgColor,
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.only(left: 12),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 24,
                    color: Colors.black,
                  )),
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
                    Photos.savePhoto(imageURL);
                  } catch (e) {
                    Get.snackbar("Sorry", "Picture not saved");
                    print("${e.toString()}");
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () async {
                  try {
                    Photos.ShareImage(imageURL);
                  } catch (e) {
                    Get.snackbar("Sorry", "Picture not shared");
                    print("${e.toString()}");
                  }
                },
              ),
            ],
          ),
          body: PhotoView(
            imageProvider: CachedNetworkImageProvider(imageURL, cacheKey: "unique_cache_key",),
            minScale: PhotoViewComputedScale.contained ,
            maxScale: PhotoViewComputedScale.covered * 3,
            initialScale: PhotoViewComputedScale.contained,
              gestureDetectorBehavior: HitTestBehavior.deferToChild,
          ),
        ));
  }
}
