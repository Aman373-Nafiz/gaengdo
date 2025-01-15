import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gaengdo/data/services/gallery_service.dart';
import 'package:gaengdo/resources/color.dart';
import 'package:gaengdo/view/widgets/GalleryCard.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(GalleryService());

    
    controller.getData();

    return Scaffold(
      backgroundColor: BgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: BgColor,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, User",
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Create your best gallery today",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10, top: 10),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.brown[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.person_outline,
                  color: Colors.black54,
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Obx(() {
          if (controller.isLoading.value == false) {
            return Center(
              child: CircularProgressIndicator(
                color: gold,
              ),
            );
          } else if (controller.datas.isEmpty) {
            return Center(
              child: Text(
                "No images available",
                style: GoogleFonts.roboto(color: Colors.black54),
              ),
            );
          }

          return MasonryGridView.builder(
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            controller: controller.scrollController,
           //itemCount: controller.datas.length,
           
            itemBuilder: (context, index) {
              int len = controller.datas.length;
              var item = controller.datas[index%len];
              return GalleryCard(item:item);
            },
          );
        }),
      ),
    );
  }
}