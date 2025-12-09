import 'package:flutter/material.dart';
import 'package:latest_news/utils/widgets/common_text_field.dart';

class SnedNotification extends StatelessWidget {
  final String dialogTitle;
  final void Function(String title, String description) onSend;
  final String titleHint;
  final String descriptionHint;

  const SnedNotification({
    super.key,
    required this.dialogTitle,
    required this.onSend,
    this.titleHint = "Enter title",
    this.descriptionHint = "Enter description",
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(dialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TTextField(
            controller: _titleController,
            label: titleHint,
          ),
          const SizedBox(height: 12),
          TTextField(
            controller: _descriptionController,
            label: descriptionHint,
            maxLines: 3,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final title = _titleController.text.trim();
            final description = _descriptionController.text.trim();
            if (title.isNotEmpty && description.isNotEmpty) {
              onSend(title, description);
              Navigator.pop(context);
            }
          },
          child: const Text("Send"),
        ),
      ],
    );
  }

  /// Helper method to show the dialog
  static Future<void> show({
    required BuildContext context,
    required String dialogTitle,
    String titleHint = "Enter title",
    String descriptionHint = "Enter description",
    required void Function(String title, String description) onSend,
  }) async {
    await showDialog(
      context: context,
      builder: (_) => SnedNotification(
        dialogTitle: dialogTitle,
        titleHint: titleHint,
        descriptionHint: descriptionHint,
        onSend: onSend,
      ),
    );
  }
}