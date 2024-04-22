import 'dart:async';

class Throttling extends Stream<bool> implements Sink<Function> {
  Throttling({Duration duration = const Duration(seconds: 1)})
      : assert(!duration.isNegative),
        _duration = duration {
    _stateSC.sink.add(true);
  }
  Duration _duration;

  /// Get current duration
  Duration get duration => _duration;

  /// Set new duration
  set duration(Duration value) {
    assert(!duration.isNegative);
    _duration = value;
  }

  bool _isReady = true;

  /// is ready
  bool get isReady => _isReady;
  Future<void> get _waiter => Future.delayed(_duration);
  final StreamController<bool> _stateSC = StreamController<bool>.broadcast();

  dynamic throttle(Function func) {
    if (!_isReady) {
      return null;
    }
    _stateSC.sink.add(false);
    _isReady = false;
    _waiter.then((_) {
      _isReady = true;
      if (!_stateSC.isClosed) {
        _stateSC.sink.add(true);
      }
    });
    return Function.apply(func, []);
  }

  @override
  StreamSubscription<bool> listen(
    void onData(bool event)?, {
    Function? onError,
    void onDone()?,
    bool? cancelOnError,
  }) =>
      _stateSC.stream.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );

  /// Closing instances of Sink prevents
  /// memory leaks and unexpected behavior.
  @Deprecated('Use [close] instead')
  void dispose() => close();

  @override
  dynamic add(Function data) => throttle(data);

  @override
  Future<void> close() => _stateSC.close();
}
