import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gaengdo/resources/color.dart';
import 'package:gaengdo/view/Screen/Details.dart';
import 'package:google_fonts/google_fonts.dart';

class GalleryCard extends StatelessWidget {
  final dynamic item;

  const GalleryCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final String? imageUrl = item?.urls?.small;


    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            "Image unavailable",
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              color: Colors.black54,
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
       
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(imageURL: imageUrl),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: BgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: AspectRatio(
                aspectRatio: (item.width ?? 1) / (item.height ?? 1),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        color: gold,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.error, color: Colors.deepPurple),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.user?.name ?? "Unknown",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.star_border,
                    size: 20,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
