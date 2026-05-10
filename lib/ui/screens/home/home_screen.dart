import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../themes/app_colors.dart";
import "../settings/settings_tab.dart";
import "home_controller.dart";
import "meeting_list/meeting_list_tab.dart";

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  static const _titles = ["MoM Note", "Pengaturan"];

  static const _tabs = [MeetingListTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Obx(() => Text(_titles[controller.currentIndex.value])), automaticallyImplyLeading: false),
      body: Obx(() => IndexedStack(index: controller.currentIndex.value, children: _tabs)),
      bottomNavigationBar: Obx(
        () => DecoratedBox(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.divider)),
          ),
          position: DecorationPosition.foreground,
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.event_note_outlined),
                activeIcon: Icon(Icons.event_note),
                label: "Beranda",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: "Pengaturan",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
