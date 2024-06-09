// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimerStateAdapter extends TypeAdapter<TimerState> {
  @override
  final int typeId = 0;

  @override
  TimerState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimerState(
      (fields[0] as Map).cast<String, int>(),
      (fields[1] as Map).cast<String, bool>(),
      (fields[2] as Map).cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TimerState obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.timers)
      ..writeByte(1)
      ..write(obj.isRunning)
      ..writeByte(2)
      ..write(obj.currentTimes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TimerStateAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
