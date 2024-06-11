import 'package:hive/hive.dart';

part 'timer_state.g.dart';

///======================================================================================================
/// Model class representing the state of timers for tasks.
///
/// This class is used to represent the state of timers, including the duration of each timer, whether
/// it is currently running, and the timestamp when it was last started. It is serialized and persisted
/// using Hive.
///
/// Features:
///   - Store timer durations for tasks.
///   - Track whether timers are currently running.
///   - Save the timestamp when timers were last started.
///
/// Dependencies:
///   - `Hive`: Used for serialization and persistence.
///
/// Usage:
///   - Instantiate `TimerState` with timer durations, running states, and current times.
///   - Serialize and persist instances of `TimerState` using Hive.
///======================================================================================================

@HiveType(typeId: 0)
class TimerState extends HiveObject {
  @HiveField(0)
  final Map<String, int> timers;

  @HiveField(1)
  final Map<String, bool> isRunning;

  @HiveField(2)
  final Map<String, String> currentTimes;

  TimerState(this.timers, this.isRunning, this.currentTimes);
}
