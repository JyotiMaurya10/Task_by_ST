import 'package:video_player/controllers/setting_controller.dart';
import 'package:video_player/widgets/setting_shimmer.dart';
import 'package:video_player/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingController controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: controller.selectedBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 40.0),
                child: Text("Select Language",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    )),
              ),
              Obx(() {
                if (controller.languages.isEmpty) {
                  return const SettingShimmer(count: 6);
                }
                return Center(
                  child: Wrap(
                      spacing: 30,
                      runSpacing: 40,
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.center,
                      children: List.generate(controller.languages.length, (index) {
                        final language = controller.languages[index]['label'] ?? "";
                        return GestureDetector(
                          onTap: () => controller.selectedLanguages.value = index,
                          child: Container(
                            width: 142,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.selectedLanguages.value == index ? highlightColor : disableColor2,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: controller.selectedLanguages.value == index ? Colors.green[900]! : greyColor,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              language,
                              style: TextStyle(
                                color: controller.selectedLanguages.value == index ? Colors.green[900] : Colors.black,
                              ),
                            ),
                          ),
                        );
                      })),
                );
              }),
              const Padding(
                padding: EdgeInsets.only(bottom: 40.0, top: 50),
                child: Text("Select Color",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    )),
              ),
              Obx(() {
                if (controller.colors.isEmpty) {
                  return const SettingShimmer(count: 5);
                }
                return Center(
                  child: Wrap(
                    spacing: 30,
                    runSpacing: 40,
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    children: List.generate(controller.colors.length, (index) {
                      final color = controller.colors[index]['label'] ?? "";
                      return GestureDetector(
                        onTap: () => controller.selectedColor.value = index,
                        child: Container(
                          width: 142,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: getColor(color),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: controller.selectedColor.value == index ? Colors.green[900]! : greyColor,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                color,
                                style: TextStyle(
                                  color: controller.selectedColor.value == index ? Colors.green[900] : Colors.black,
                                ),
                              ),
                              if (controller.selectedColor.value == index)
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.green[900],
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(String colorName) {
    switch (colorName) {
      case 'Beige (default)':
        return const Color(0xFFF5F5DC);
      case 'Sea Green':
        return const Color.fromARGB(255, 27, 216, 109);
      case 'Hot Pink':
        return const Color(0xFFFF69B4);
      case 'Lavender':
        return const Color(0xFFE6E6FA);
      case 'Lemon Yellow':
        return const Color(0xFFFFF700);
      default:
        return const Color(0xFF808080);
    }
  }
}
