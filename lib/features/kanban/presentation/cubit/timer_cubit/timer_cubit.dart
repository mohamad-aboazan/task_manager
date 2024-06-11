import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'timer_state.dart';

///======================================================================================================
/// BLoC for managing timers associated with tasks in the Kanban board.
///
/// This BLoC handles the start, stop, and toggle functionalities of timers for each task. It also manages
/// the state of timers and saves their state using Hive for persistence.
///
/// Features:
///   - Start, stop, and toggle timers for tasks.
///   - Save and load timer state using Hive for persistence.
///   - Check if a task's timer is currently running.
///
/// Dependencies:
///   - `Hive`: Used for local storage to save and load timer states.
///   - `TimerState`: Model class representing the state of timers.
///
/// Usage:
///   - Create an instance of `TimerBloc` in the application to manage timers associated with tasks.
///   - Call methods like `startTimer`, `stopTimer`, or `toggleTimer` to control timers for specific tasks.
///   - Check if a task's timer is running using `isTaskRunning`.
///
///======================================================================================================

class TimerBloc extends Cubit<Map<String, int>> {
  TimerBloc() : super({}) {
    _initializeHive();
  }

  final Map<String, Timer> _timers = {};
  final Map<String, bool> _isRunning = {};
  final Map<String, String> _currentTimes = {};
  late Box<TimerState> _box;

  Future<void> _initializeHive() async {
    Hive.registerAdapter(TimerStateAdapter());
    _box = await Hive.openBox<TimerState>('timerState');
    _loadState();
  }

  void _loadState() {
    if (_box.isNotEmpty) {
      TimerState? timerState = _box.get('state');
      if (timerState != null) {
        for (var i = 0; i < timerState.currentTimes.keys.length; i++) {
          String taskId = timerState.currentTimes.keys.toList()[i];
          String currentTime = timerState.currentTimes[taskId]!;
          if (timerState.isRunning.containsKey(taskId) && timerState.isRunning[taskId]!) {
            DateTime currentDateTime = DateTime.parse(currentTime);
            DateTime now = DateTime.now();
            Duration difference = now.difference(currentDateTime);
            timerState.timers[taskId] = (timerState.timers[taskId] ?? 0) + difference.inSeconds;
          }
        }
        emit(timerState.timers);
        _isRunning.addAll(timerState.isRunning);
        _restartTimers();
      }
    }
  }

  void _saveState() {
    final timerState = TimerState(state, _isRunning, _currentTimes);
    _box.put('state', timerState);
  }

  void _restartTimers() {
    _isRunning.forEach((taskId, isRunning) {
      if (isRunning) {
        startTimer(taskId);
      }
    });
  }

  @override
  void emit(Map<String, int> state) {
    super.emit(state);
    _saveState();
  }

  void startTimer(String taskId) {
    _isRunning[taskId] = true;
    final newState = Map<String, int>.from(state);
    if (newState.containsKey(taskId)) {
      newState[taskId] = newState[taskId]!;
      emit(newState);
    }
    _timers[taskId] = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newState = Map<String, int>.from(state);
      if (newState.containsKey(taskId)) {
        newState[taskId] = newState[taskId]! + 1;
      } else {
        newState[taskId] = 1;
      }
      _currentTimes[taskId] = DateTime.now().toIso8601String();
      emit(newState);
    });
  }

  void stopTimer(String taskId) {
    if (_timers.containsKey(taskId)) {
      _timers[taskId]!.cancel();
      _isRunning[taskId] = false;
      final newState = Map<String, int>.from(state);
      if (state.containsKey(taskId)) {
        newState[taskId] = newState[taskId]!;
      }
      emit(newState);
    }
  }

  void toggleTimer(String taskId) {
    if (_isRunning.containsKey(taskId) && _isRunning[taskId]!) {
      stopTimer(taskId);
    } else {
      startTimer(taskId);
    }
  }

  String getFormattedTime(String taskId) {
    final seconds = state[taskId] ?? 0;
    final hours = (seconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$remainingSeconds';
  }

  bool isTaskRunning(String taskId) {
    return _isRunning.containsKey(taskId) && _isRunning[taskId]!;
  }

  @override
  Future<void> close() {
    _timers.forEach((_, timer) {
      timer.cancel();
    });
    _box.close();
    return super.close();
  }
}
