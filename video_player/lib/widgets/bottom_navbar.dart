import 'package:video_player/controllers/setting_controller.dart';
import 'package:video_player/pages/categories_screen.dart';
import 'package:video_player/pages/settings_screen.dart';
import 'package:video_player/pages/discover_screen.dart';
import 'package:video_player/pages/profile_screen.dart';
import 'package:video_player/pages/home_screen.dart';
import 'package:video_player/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});
  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.bottomNavItems.isEmpty) {
        return Scaffold(
          body: SettingsScreen(),
          bottomNavigationBar: buildShimmerNavBar(),
        );
      }

      return Scaffold(
        body: IndexedStack(index: controller.selectedIndex.value, children: [
          SettingsScreen(),
          const CategoriesScreen(),
          HomeScreen(),
          const DiscoverScreen(),
          const ProfileScreen(),
        ]),
        bottomNavigationBar: Container(
          color: headingColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              controller.bottomNavItems.length,
              (index) {
                var item = controller.bottomNavItems[index];
                return GestureDetector(
                  onTap: () => controller.changeIndex(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(
                          () => Icon(
                            getIconData(item['label']!),
                            color: controller.selectedIndex.value == index ? controller.selectedBackgroundColor : highlightColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['label']!,
                          style: const TextStyle(
                            color: highlightColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }

  Widget buildShimmerNavBar() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        color: headingColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 50,
                    height: 10,
                    color: Colors.white,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  IconData getIconData(String iconName) {
    switch (iconName) {
      case 'Settings':
        return Icons.settings;
      case 'Categories':
        return Icons.category_rounded;
      case 'Home':
        return Icons.home;
      case 'Discover':
        return Icons.science;
      case 'Profile':
        return Icons.person_pin_circle;
      default:
        return Icons.help;
    }
  }
}
