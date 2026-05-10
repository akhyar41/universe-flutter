import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";

import "app.dart";
import "core/services/hive_service.dart";
import "core/services/storage_service.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  final hiveService = await HiveService().init();
  Get.put(hiveService, permanent: true);

  final storageService = await StorageService().init();
  Get.put(storageService, permanent: true);

  await GetStorage.init();

  runApp(const App());
}
