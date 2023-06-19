import 'package:hive/hive.dart';
import 'package:stand/models/position_record.dart';

class HiveService {
  late Box<PositionRecord> positionRecords;

  Future<void> init() async {
    // Adapters
    Hive.registerAdapter(PositionRecordAdapter());

    // Boxes
    await Hive.openBox<PositionRecord>('position_records');

    // Box getters
    positionRecords = Hive.box<PositionRecord>('position_records');
  }
}
