import 'dart:convert';
import 'package:gaengdo/data/models/gallery_model.dart';
import 'package:gaengdo/util/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GalleryService extends GetxController {
  RxBool isLoading = false.obs;
  var datas = <Gallery>[].obs;
  Future<void> getData() async {
    try {
      var url = Uri.parse(api); 
      var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );
//isLoading.value = true;
      if (response.statusCode == 200) {
        isLoading.value = true;
        
      var decodedData = jsonDecode(response.body);
        datas.value = (decodedData as List).map((e) => Gallery.fromJson(e)).toList();
      } else {
       
        print("Error: HTTP ${response.statusCode} - ${response.reasonPhrase}");
       
      }
    } catch (e) {
 
      print("Error: $e");
      
    
    }
  }
}
