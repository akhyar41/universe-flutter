import "package:flutter/material.dart";
import "package:get/get.dart";
import "../../../core/services/storage_service.dart";
import "app_routes.dart";

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final storage = Get.find<StorageService>();
    if (!storage.hasToken()) {
      return const RouteSettings(name: AppRoutes.login);
    }
    return null;
  }
}
