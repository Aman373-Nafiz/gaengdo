import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gaengdo/resources/color.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
      // Check permissions first
      bool hasPermission = await _handlePermissions();
      if (!hasPermission) return;

      

      // Download image
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        throw Exception('Download failed');
      }

      // Create directory if it doesn't exist
      Directory? directory = await getExternalStorageDirectory();
      if (directory == null) {
        directory = await getTemporaryDirectory();
      }
      
      // Save image with unique name
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${directory.path}/image_$timestamp.jpg');
      await file.writeAsBytes(response.bodyBytes);

      
      final saved = await GallerySaver.saveImage(
        file.path,
        toDcim: true,
        albumName: "PhotoView"
      );

      // Close loading dialog
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
}