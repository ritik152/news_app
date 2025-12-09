import 'package:flutter/material.dart';
import 'package:latest_news/utils/app_utils.dart';
import 'package:latest_news/utils/colors.dart';
import 'package:latest_news/utils/responsive.dart';
import 'package:latest_news/utils/widgets/common_text.dart';

import '../../../utils/widgets/common_image.dart';

class NewsDetailView extends StatelessWidget {
  final Map article;

  const NewsDetailView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        title: TText("Latest News",color: AppColors.darkTextPrimary,),
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.darkTextPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // IMAGE HEADER WITH ROUNDED CORNERS + SHADOW
            Hero(
              tag: article["title"],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: (article["image"] == null || article["image"].isEmpty)?SizedBox():CommonImage(image: article["image"],height: responsive.scale(200),width: responsive.width,type: ImageType.network,),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                article["title"] ?? "",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // SOURCE + DATE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  if(article["author"] != null && article["author"].isNotEmpty)Icon(Icons.newspaper, size: 18, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  if(article["author"] != null && article["author"].isNotEmpty)Text(
                    article["author"],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const Spacer(),
                  if(article["publishedAt"] != null && article["publishedAt"].isNotEmpty)Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  if(article["publishedAt"] != null && article["publishedAt"].isNotEmpty)const SizedBox(width: 6),
                  if(article["publishedAt"] != null && article["publishedAt"].isNotEmpty)Text(
                    AppUtils.formatDate(article["publishedAt"]),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // CONTENT CARD
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                article["description"] ?? "No content available.",
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
    ;
  }
}
