import 'package:hive/hive.dart';

part 'timer_state.g.dart';

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
