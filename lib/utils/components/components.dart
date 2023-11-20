import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class UtilityComponents {
  UtilityComponents._();

  static selectGendersheet(
      {required BuildContext context,
      required TextEditingController controller}) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.male),
              title: const Text("Male"),
              onTap: () => controller.text = 'Male',
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.female),
              title: const Text("Female"),
              onTap: () => controller.text = 'Female',
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Ionicons.transgender),
              title: const Text("Other"),
              onTap: () => controller.text = 'Other',
            )
          ],
        );
      },
    );
  }

  static selectImageSheet({
    required BuildContext context,
    required  Function(ImageSource imageSource) onTap,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.browse_gallery),
              title: const Text("Gallery"),
              onTap: () => onTap(ImageSource.gallery),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
              onTap: () => onTap(ImageSource.camera),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
