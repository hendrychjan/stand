import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:stand/getx/app_controller.dart';

part 'position_record.g.dart';

// Generate script: dart run build_runner build

@HiveType(typeId: 0)
class PositionRecord {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String title;

  @HiveField(3)
  String latitude;

  @HiveField(4)
  String longitude;

  @HiveField(5)
  String? comment;

  PositionRecord({
    required this.id,
    required this.date,
    required this.title,
    required this.latitude,
    required this.longitude,
    this.comment,
  });

  factory PositionRecord.fromMap(Map<String, dynamic> map) {
    return PositionRecord(
      id: map['id'],
      date: DateTime.parse(map['date']),
      title: map['title'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      comment: map['comment'],
    );
  }

  factory PositionRecord.fromJson(String json) {
    return PositionRecord.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'title': title,
      'latitude': latitude,
      'longitude': longitude,
      'comment': comment,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  Future<void> save() async {
    int newId = await AppController.to.hiveService.positionRecords.add(this);
    id = newId;
  }

  Future<void> update() async {
    await AppController.to.hiveService.positionRecords.put(id, this);
  }

  Future<void> delete() async {
    await AppController.to.hiveService.positionRecords.delete(id);
  }

  static Future<PositionRecord?> getById(int id) async {
    return AppController.to.hiveService.positionRecords.get(id);
  }

  static Future<List<PositionRecord>> getAll() async {
    return AppController.to.hiveService.positionRecords.values.toList();
  }
}
