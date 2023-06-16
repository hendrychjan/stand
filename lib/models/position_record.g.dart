// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PositionRecordAdapter extends TypeAdapter<PositionRecord> {
  @override
  final int typeId = 0;

  @override
  PositionRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionRecord(
      id: fields[0] as int,
      date: fields[1] as DateTime,
      title: fields[2] as String,
      latitude: fields[3] as String,
      longtitude: fields[4] as String,
      comment: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PositionRecord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longtitude)
      ..writeByte(5)
      ..write(obj.comment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
