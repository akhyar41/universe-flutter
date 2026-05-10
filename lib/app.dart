import "package:flutter/material.dart";
import "package:get/get.dart";
import "ui/bindings/initial_binding.dart";
import "ui/routes/app_pages.dart";
import "ui/routes/app_routes.dart";
import "ui/themes/app_theme.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "MoM Note",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      defaultTransition: Transition.noTransition,
    );
  }
}
