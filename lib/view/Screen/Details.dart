import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gaengdo/resources/color.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class Details extends StatelessWidget {
  var imageURL;
  Details({super.key, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,home:Scaffold(
      backgroundColor: BgColor,
       appBar: AppBar(
        title: Text('Photo View'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () async {
              try {
              
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to save photo.')));
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
      
            },
          ),
        ],
      ),
      body: PhotoView(imageProvider: CachedNetworkImageProvider(imageURL),  minScale: PhotoViewComputedScale.contained * 0.8,
  maxScale: PhotoViewComputedScale.covered * 1.8,
  initialScale: PhotoViewComputedScale.contained,),
    ));
  }
}
