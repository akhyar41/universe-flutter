import "package:get/get.dart";
import "../../../core/services/auth_service.dart";
import "../../../core/services/meeting_service.dart";

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService(), permanent: true);
    Get.put(MeetingService(), permanent: true);
  }
}
