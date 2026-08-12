import 'dart:async';
import 'dart:ui';

/// A per-instance debouncer. Prefer this over [runDebouncer] when you have more
/// than one independent debounced action (e.g. two search fields), since each
/// instance owns its own [Timer] and can be disposed.
///
/// ```dart
/// final _debouncer = Debouncer(milliseconds: 500);
/// // in onChanged:
/// _debouncer.run(() => search(query));
/// // in dispose:
/// _debouncer.dispose();
/// ```
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({this.milliseconds = 800});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void cancel() => _timer?.cancel();

  void dispose() => _timer?.cancel();
}

/// Legacy single-timer debouncer kept for backwards compatibility. Note that it
/// shares one global timer across all call sites, so concurrent debounced
/// actions cancel each other — prefer the [Debouncer] class for new code.
Timer? timer;

void runDebouncer(VoidCallback action, {int milliseconds = 800}) {
  timer?.cancel();
  timer = Timer(Duration(milliseconds: milliseconds), action);
}
