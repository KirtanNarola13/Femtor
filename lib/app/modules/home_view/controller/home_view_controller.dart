import 'package:femtor/app/utils/constants.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;

  final masterClass = [
    {"imageUrl": Images.dummyCarouselImage},
    {"imageUrl": Images.dummyCarouselImage},
    {"imageUrl": Images.dummyCarouselImage},
  ].obs;
  // Dummy Data
  final coaches = [
    {
      "name": "Anaya Gupta",
      "title": "Lipstick Artist & Coach",
      "imageUrl": Images.anyaGuptaDummy,
      "coursesCount": "10",
    },
    {
      "name": "Kavya Mahika",
      "title": "Foundation Artist & Coach",
      "imageUrl": Images.kavyaMahikaDummy,

      "coursesCount": "10",
    },
  ].obs;

  final continueWatching = [
    {
      "episodes": "03/10 Episodes",
      "title": "Lipstick tutorial : Create your own lip care...",
      "subtitle": "Anaya Gupta Lipstick Artist...",
      "imageUrl": Images.Dummy3Category,
      "progress": "0.3",
    },
    {
      "episodes": "01/07 Episodes",
      "title": "Cosmetic & Blush on your own lip care...",
      "subtitle": "Kavya Mahika Foundation...",
      "imageUrl": Images.Dummy1Category,
      "progress": "0.2",
    },
  ].obs;

  final categories = [
    {"title": "Lipstick tutorials", "imageUrl": Images.Dummy1Category},
    {"title": "Cosmetic tutorials", "imageUrl": Images.Dummy2Category},
    {"title": "Eyeliner tutorials", "imageUrl": Images.Dummy3Category},
    {"title": "Cosmetic tutorials", "imageUrl": Images.Dummy1Category},
  ].obs;
  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    isLoading.value = true;
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    // In a real app, you would fetch data from an API here
    isLoading.value = false;
  }

  void onTryProTapped() {
    Get.toNamed(Routes.PREMIUM);
  }
}
