import 'package:get/get.dart';
import 'package:latest_news/data/services/apis/api_service.dart';
import 'package:latest_news/data/services/apis/apis.dart';

class NewsController extends GetxController {

  RxDouble tapScale = 1.0.obs;
  RxBool isLoading = false.obs;
  RxList newsList = [].obs;

  @override
  void onInit() {
    super.onInit();
    loadNews();
  }

  Future<void> loadNews() async {
    isLoading.value = true;
    try {
      Map<String,String> mapData = {
        "access_key":Apis.apiKey
      };
      final data = await ApiService.get(query: mapData);
      newsList.assignAll(data["data"]);
    } catch (e) {
      print("ERROR: $e");
    }
    isLoading.value = false;
  }
}
