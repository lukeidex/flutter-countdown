import 'dart:async';

import 'package:countdown_flutter/utils.dart';
import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  Countdown({
    Key key,
    @required this.duration,
    @required this.builder,
    this.onFinish,
    this.interval = const Duration(seconds: 1),
  }) : super(key: key);

  final Duration duration;
  final Duration interval;
  final void Function() onFinish;
  final Widget Function(BuildContext context, Duration remaining) builder;

  final _CountdownState _countdownState = _CountdownState();
  @override
  _CountdownState createState() => _countdownState;

  void reset([Duration overrideDuration]) {
    _countdownState.reset(overrideDuration);
  }

  void pause() {
    _countdownState.pause();
  }

  void resume() {
    _countdownState.resume();
  }
}

class _CountdownState extends State<Countdown> {
  Timer _timer;
  Duration _duration;
  @override
  void initState() {
    _duration = widget.duration;
    startTimer();

    super.initState();
  }

  void reset([Duration overrideDuration]) {
    setState(() {
      _duration = overrideDuration ?? widget.duration;
    });
    _timer?.cancel();
    startTimer();
  }

  void pause() {
    if (_timer?.isActive == true) setState(() => _timer?.cancel());
  }

  void resume() {
    if (_timer?.isActive == true) _timer?.cancel();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(widget.interval, timerCallback);
  }

  void timerCallback(Timer timer) {
    setState(() {
      if (_duration.inSeconds == 0) {
        timer.cancel();
        if (widget.onFinish != null) widget.onFinish();
      } else {
        _duration = Duration(seconds: _duration.inSeconds - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _duration);
  }
}

class CountdownFormatted extends StatefulWidget {
  CountdownFormatted({
    Key key,
    @required this.duration,
    @required this.builder,
    this.onFinish,
    this.interval = const Duration(seconds: 1),
    this.formatter,
  }) : super(key: key);

  final Duration duration;
  final Duration interval;
  final void Function() onFinish;

  /// An function to format the remaining time
  final String Function(Duration) formatter;

  final Widget Function(BuildContext context, String remaining) builder;

  final _CountdownFormattedState _countdownFormattedState =
      _CountdownFormattedState();
  @override
  _CountdownFormattedState createState() => _countdownFormattedState;

  void reset([Duration overrideDuration]) {
    _countdownFormattedState.reset(overrideDuration);
  }

  void pause() {
    _countdownFormattedState.pause();
  }

  void resume() {
    _countdownFormattedState.resume();
  }
}

class _CountdownFormattedState extends State<CountdownFormatted> {
  Function(Duration) _formatter() {
    if (widget.formatter != null) return widget.formatter;
    if (widget.duration.inHours >= 1) return formatByHours;
    if (widget.duration.inMinutes >= 1) return formatByMinutes;

    return formatBySeconds;
  }

  void reset([Duration overrideDuration]) {
    _countdown.reset(overrideDuration);
  }

  void pause() {
    _countdown.pause();
  }

  void resume() {
    _countdown.resume();
  }

  Countdown _countdown;

  @override
  void initState() {
    super.initState();
    _countdown = Countdown(
      key: widget.key,
      interval: widget.interval,
      onFinish: widget.onFinish,
      duration: widget.duration,
      builder: (BuildContext ctx, Duration remaining) {
        return widget.builder(ctx, _formatter()(remaining));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _countdown;
  }
}
