import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gaengdo/resources/color.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
class PhotoController extends GetxController {
  Future<bool> _handlePermissions() async {
    if (Platform.isAndroid) {
      // For Android 13 (API level 33) and above
      if (await Permission.photos.request().isGranted) {
        return true;
      }
      
      // For Android 12 and below
      if (await Permission.storage.request().isGranted) {
        return true;
      }

      // If both permission requests failed, guide user to settings
      Get.snackbar(
        "Permission Required", 
        "Please enable storage permissions in Settings",
        backgroundColor: Colors.red,
        colorText: BgColor,
        duration: Duration(seconds: 3),
        mainButton: TextButton(
          onPressed: () => openAppSettings(),
          child: Text('Open Settings', style: TextStyle(color: BgColor)),
        ),
      );
      return false;
    }
    return true; // For iOS
  }

  Future<void> savePhoto(String imageUrl) async {
    try {

      bool hasPermission = await _handlePermissions();
      if (!hasPermission) return;

      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        throw Exception('Download failed');
      }


      Directory? directory = await getExternalStorageDirectory();
      if (directory == null) {
        directory = await getTemporaryDirectory();
      }
      
    
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${directory.path}/image_$timestamp.jpg');
      await file.writeAsBytes(response.bodyBytes);

      
      final saved = await GallerySaver.saveImage(
        file.path,
        toDcim: true,
        albumName: "PhotoView"
      );

      
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      if (saved == true) {
        Get.snackbar(
          "Success", 
          "Image saved to gallery",
          backgroundColor: gold,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        throw Exception('Failed to save image');
      }

     
      if (await file.exists()) {
        await file.delete();
      }

    } catch (e) {
      print("Error saving image: $e"); 
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      
      Get.snackbar(
        "Error", 
        "Couldn't save the image",
        backgroundColor: Colors.red,
        colorText: BgColor,
        duration: Duration(seconds: 2),
      );
    }
  }
  
  Future<void> ShareImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        throw Exception('Download failed');
      }

      // Get temporary directory to save image
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/share_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final imageFile = File(imagePath);
      
      // Save image temporarily
      await imageFile.writeAsBytes(response.bodyBytes);

      // Close loading dialog
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      // Share image
      await Share.shareXFiles(
        [XFile(imagePath)],
        text: 'Check out this image!',
      );

      // Clean up temporary file
      if (await imageFile.exists()) {
        await imageFile.delete();
      }

    } catch (e) {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      
      Get.snackbar(
        "Error", 
        "Couldn't share the image",
        backgroundColor: Colors.red,
        colorText: BgColor,
        duration: Duration(seconds: 2),
      );
      print("Share error: $e");
    }
  }

//   Future<void>ShareImage(String Imageurl) async{
//     try{     
//        final directory = await getTemporaryDirectory();
//       final timestamp = DateTime.now().millisecondsSinceEpoch;
// var path = '${directory.path}/image_$timestamp.jpg';
//       //final file = File(path);
//       final result = await Share.shareXFiles([XFile(path)], text: 'Great picture');

// if (result.status == ShareResultStatus.success) {
//     print('Thank you for sharing the picture!');
//      Get.snackbar(
//         "Thank you", 
//         "for sharing the picture!",
//         backgroundColor: gold,
//         colorText: BgColor,
//         duration: Duration(seconds: 3),
//       );
// }
//     }
//     catch(e){
//  Get.snackbar(
//         "Shared Failed!", 
//         "Picture was not shared",
//         backgroundColor: gold,
//         colorText: BgColor,
//         duration: Duration(seconds: 3),
//       );
//     }
//      final response = await http.get(Uri.parse(Imageurl));
//       if (response.statusCode != 200) {
//         throw Exception('Download failed');
//       }
// final directory = await getTemporaryDirectory();
// final timestamp = DateTime.now().millisecondsSinceEpoch;
// var path = '${directory.path}/image_$timestamp.jpg';
//       final file = File(path);
//       await file.writeAsBytes(response.bodyBytes);
//         await Share.shareXFiles(
//         [XFile(path)],
//         text: 'Check out this image!',
//       );

     

// }
}