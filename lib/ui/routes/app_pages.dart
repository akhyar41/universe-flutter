import "package:get/get.dart";

import "../screens/splash/splash_screen.dart";
import "../screens/splash/splash_controller.dart";
import "../screens/auth/login/login_screen.dart";
import "../screens/auth/login/login_controller.dart";
import "../screens/auth/register/register_screen.dart";
import "../screens/auth/register/register_controller.dart";
import "../screens/home/home_screen.dart";
import "../screens/home/home_controller.dart";
import "../screens/home/meeting_list/meeting_list_controller.dart";
import "../screens/home/meeting_form/meeting_form_screen.dart";
import "../screens/home/meeting_form/meeting_form_controller.dart";
import "../screens/settings/settings_controller.dart";
import "../screens/settings/update_profile/update_profile_screen.dart";
import "../screens/settings/update_profile/update_profile_controller.dart";
import "../screens/settings/update_password/update_password_screen.dart";
import "../screens/settings/update_password/update_password_controller.dart";
import "app_routes.dart";
import "app_middleware.dart";

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder<void>(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder<void>(() {
        Get.put(LoginController());
      }),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: BindingsBuilder<void>(() {
        Get.put(RegisterController());
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: BindingsBuilder<void>(() {
        Get.put(HomeController());
        Get.put(MeetingListController());
        Get.put(SettingsController());
      }),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.meetingForm,
      page: () => const MeetingFormScreen(),
      binding: BindingsBuilder<void>(() {
        Get.put(MeetingFormController());
      }),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.updateProfile,
      page: () => const UpdateProfileScreen(),
      binding: BindingsBuilder<void>(() {
        Get.put(UpdateProfileController());
      }),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.updatePassword,
      page: () => const UpdatePasswordScreen(),
      binding: BindingsBuilder<void>(() {
        Get.put(UpdatePasswordController());
      }),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
