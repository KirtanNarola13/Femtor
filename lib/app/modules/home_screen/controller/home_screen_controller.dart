import 'dart:async';

import 'package:femtor/app/utils/event_bus_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  late PageController pageController;
  var selectedIndex = 0.obs;
  late StreamSubscription _eventBusSubscription;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _eventBusSubscription = EventBusHelper.instance
        .on<NavigationEvent>()
        .listen((event) {
          changePage(event.pageIndex);
        });
  }

  @override
  void onClose() {
    pageController.dispose();
    _eventBusSubscription.cancel();
    super.onClose();
  }

  // This is called when the user swipes the page.
  void onPageChanged(int index) {
    selectedIndex.value = index;
  }

  // This is called when a navigation item is tapped.
  void changePage(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}
