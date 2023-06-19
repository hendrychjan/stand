import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stand/forms/position_record_form.dart';
import 'package:stand/models/position_record.dart';

class PositionDetailPage extends StatefulWidget {
  final PositionRecord position;
  final Function? onDataChanged;
  const PositionDetailPage({
    super.key,
    required this.position,
    this.onDataChanged,
  });

  @override
  State<PositionDetailPage> createState() => _PositionDetailPageState();
}

class _PositionDetailPageState extends State<PositionDetailPage> {
  Future<void> _handleDelete() async {
    await Get.dialog(
      AlertDialog(
        title: const Text("Delete"),
        content: const Text("Are you sure you want to delete this position?"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await widget.position.delete();
              if (widget.onDataChanged != null) {
                widget.onDataChanged!();
              }
              Get.back();
              Get.back();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Position"),
        foregroundColor: Get.theme.colorScheme.primary,
        actions: [
          IconButton(
            onPressed: _handleDelete,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: PositionRecordForm(
          latitude: widget.position.latitude,
          longitude: widget.position.longitude,
          initialValue: widget.position,
          short: false,
          onSubmit: (PositionRecord updatedPosition) async {
            await updatedPosition.update();
            if (widget.onDataChanged != null) {
              widget.onDataChanged!();
            }
            Get.snackbar(
              "Updated",
              "Position record has been upated",
              snackPosition: SnackPosition.TOP,
            );
          },
        ),
      ),
    );
  }
}
