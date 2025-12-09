import 'package:flutter/material.dart';
import 'package:latest_news/utils/responsive.dart';
import 'package:latest_news/utils/widgets/common_image.dart';

class NewsCardItem extends StatelessWidget {
  final Map<String, dynamic> news;

  const NewsCardItem({
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- IMAGE WITH HERO + FADE-IN ----------------
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Hero(
              tag: news["title"] ?? UniqueKey(),
              child: (news["image"] == null || news["image"].isEmpty)?SizedBox():CommonImage(image: news["image"],height: responsive.scale(200),width: responsive.width,type: ImageType.network,),
            ),
          ),

          // ---------------- CONTENT ----------------
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Source tag
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    news["author"] ?? "Unknown Source",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Title
                Text(
                  news["title"] ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 8),

                // Published date
                Text(
                  news["publishedAt"] ?? "",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
