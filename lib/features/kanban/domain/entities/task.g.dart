// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      creatorId: fields[0] as String?,
      createdAt: fields[1] as String?,
      assigneeId: fields[2] as String?,
      assignerId: fields[3] as String?,
      commentCount: fields[4] as int?,
      isCompleted: fields[5] as bool?,
      content: fields[6] as String?,
      description: fields[7] as String?,
      due: fields[8] as Due?,
      duration: fields[9] as Duration?,
      id: fields[10] as String?,
      labels: (fields[11] as List?)?.cast<String>(),
      order: fields[12] as int?,
      priority: fields[13] as int?,
      projectId: fields[14] as String?,
      sectionId: fields[15] as String?,
      parentId: fields[16] as String?,
      url: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.creatorId)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.assigneeId)
      ..writeByte(3)
      ..write(obj.assignerId)
      ..writeByte(4)
      ..write(obj.commentCount)
      ..writeByte(5)
      ..write(obj.isCompleted)
      ..writeByte(6)
      ..write(obj.content)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.due)
      ..writeByte(9)
      ..write(obj.duration)
      ..writeByte(10)
      ..write(obj.id)
      ..writeByte(11)
      ..write(obj.labels)
      ..writeByte(12)
      ..write(obj.order)
      ..writeByte(13)
      ..write(obj.priority)
      ..writeByte(14)
      ..write(obj.projectId)
      ..writeByte(15)
      ..write(obj.sectionId)
      ..writeByte(16)
      ..write(obj.parentId)
      ..writeByte(17)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DueAdapter extends TypeAdapter<Due> {
  @override
  final int typeId = 1;

  @override
  Due read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Due(
      date: fields[0] as String?,
      isRecurring: fields[1] as bool?,
      datetime: fields[2] as String?,
      string: fields[3] as String?,
      timezone: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Due obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.isRecurring)
      ..writeByte(2)
      ..write(obj.datetime)
      ..writeByte(3)
      ..write(obj.string)
      ..writeByte(4)
      ..write(obj.timezone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  final int typeId = 2;

  @override
  Duration read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Duration(
      amount: fields[0] as int?,
      unit: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Duration obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DurationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
