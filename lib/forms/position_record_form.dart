import 'package:flutter/material.dart';
import 'package:stand/models/position_record.dart';

class PositionRecordForm extends StatefulWidget {
  final Function onSubmit;
  final PositionRecord? initialValue;
  final String latitude;
  final String longitude;
  final bool short;
  const PositionRecordForm({
    super.key,
    required this.onSubmit,
    required this.latitude,
    required this.longitude,
    this.short = true,
    this.initialValue,
  });

  @override
  State<PositionRecordForm> createState() => _PositionRecordFormState();
}

class _PositionRecordFormState extends State<PositionRecordForm> {
  final _formKey = GlobalKey<FormState>();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _titleController = TextEditingController();
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _latitudeController.text = widget.latitude;
    _longitudeController.text = widget.longitude;

    if (widget.initialValue != null) {
      _latitudeController.text = widget.initialValue!.latitude;
      _longitudeController.text = widget.initialValue!.longitude;
      _titleController.text = widget.initialValue!.title;
      _commentController.text = widget.initialValue!.comment ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: "Title",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter title";
              }
              return null;
            },
          ),
          TextField(
            minLines: 5,
            maxLines: null,
            controller: _commentController,
            decoration: const InputDecoration(
              labelText: "Comment",
            ),
            keyboardType: TextInputType.multiline,
          ),
          if (!widget.short)
            TextField(
              controller: _latitudeController,
              decoration: const InputDecoration(
                labelText: "Latitude",
              ),
            ),
          if (!widget.short)
            TextField(
              controller: _longitudeController,
              decoration: const InputDecoration(
                labelText: "Longitude",
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                widget.onSubmit(
                  PositionRecord(
                    id: widget.initialValue?.id ?? 0,
                    date: DateTime.now(),
                    title: _titleController.text,
                    latitude: _latitudeController.text,
                    longitude: _longitudeController.text,
                    comment: _commentController.text,
                  ),
                );
              },
              child: const Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
