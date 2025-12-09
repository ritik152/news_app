import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latest_news/modules/news/widget/news_card_item.dart';
import 'package:latest_news/modules/news/widget/news_card_wrapper.dart';
import 'package:latest_news/modules/news/widget/shimmer_card.dart';
import 'package:latest_news/utils/colors.dart';
import 'package:latest_news/utils/widgets/common_text.dart';

import '../../data/services/firebase/firebase_message_service.dart';
import '../dialogs/send_notification.dart';
import 'news_controller.dart';
import 'news_detail/news_detail_view.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NewsController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        title: TText("Latest News", color: AppColors.darkTextPrimary),
        actions: [

          ///Send Notification
          IconButton(
            icon: const Icon(Icons.notification_add, color: Colors.white),
            onPressed: () {
              SnedNotification.show(
                context: context,
                dialogTitle: "Send Notification",
                titleHint: "Notification Title",
                descriptionHint: "Notification Description",
                onSend: (title, description) async {
                  // handle sending notification
                  print("Title: $title");
                  print("Description: $description");
                  String? token = await FirebaseMessageService.instance.getDeviceToken();
                  if (token != null) {
                    await FirebaseMessageService.instance.sendNotification(
                      projectId: "news-app-b9928",
                      token: token,
                      title: title,
                      body: description,
                    );
                  }
                },
              );
            },
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: 5, // number of placeholder cards
            itemBuilder: (_, __) => const ShimmerNewsCard(),
          );
        }

        // ---- Your real list ----
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.newsList.length,
          itemBuilder: (_, index) {
            final news = controller.newsList[index];
            return NewsCardWrapper(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailView(article: news),
                ),
              ),
              child: NewsCardItem(news: news),
            );
          },
        );
      }),
    );
  }
}
