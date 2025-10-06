import 'package:get/get.dart';

import '../controller/create_profile_controller.dart';

class CreateProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateProfileController());
  }
}
