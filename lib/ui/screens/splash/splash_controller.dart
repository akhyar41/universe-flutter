import "package:get/get.dart";
import "../../routes/app_routes.dart";
import "../../../../core/services/storage_service.dart";

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    final storage = Get.find<StorageService>();
    if (storage.hasToken()) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
