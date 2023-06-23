import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stand/forms/position_record_form.dart';
import 'package:stand/models/position_record.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        title: Text(
          AppLocalizations.of(context)!.positionDetailPage_deleteDialogTitle,
        ),
        content: Text(
          AppLocalizations.of(context)!
              .positionDetailPage_deleteDialogDescription,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () async {
              await widget.position.delete();
              if (widget.onDataChanged != null) {
                widget.onDataChanged!();
              }
              Get.back(); // close the dialog
              Get.back(); // close the detail page
            },
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.positionDetailPage_appBarTitle,
        ),
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
            if (context.mounted) {
              Get.snackbar(
                AppLocalizations.of(context)!
                    .positionDetailPage_updatedSnackbarTitle,
                AppLocalizations.of(context)!
                    .positionDetailPage_updatedSnackbarDescription,
                snackPosition: SnackPosition.TOP,
              );
            }
          },
        ),
      ),
    );
  }
}
