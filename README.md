# flutter-countdown
#### + Added reset, pause, resume

A simple countdown plugin for flutter ⌛

![gif](https://github.com/lukeidex/flutter-countdown/blob/master/images/countdown_alt.gif?raw=true)

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Installation (pubspec.yaml)
``` yaml
  countdown_flutter:
    git:
      url: https://github.com/lukeidex/flutter-countdown.git
```

### Usage

#### Countdown

```dart
import 'package:flutter/material.dart';
import 'package:countdown_flutter/countdown_flutter.dart';

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Assign countdown widget to variable
    final Countdown countdown = Countdown(
      duration: Duration(seconds: 10),
      onFinish: () {
        print('finished!');
      },
      builder: (BuildContext ctx, Duration remaining) {
        return Text('${remaining.inMinutes}:${remaining.inSeconds}');
      },
    );

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          countdown,
          RaisedButton(
            onPressed: countdown.reset,
            child: Text('Reset'),
          ),
          RaisedButton(
            onPressed: countdown.resume,
            child: Text('Resume'),
          ),
          RaisedButton(
            onPressed: countdown.pause,
            child: Text('Pause'),
          ),
        ],
      ),
    );
  }
}

```

#### CountdownFormatted

```dart
import 'package:flutter/material.dart';
import 'package:countdown_flutter/countdown_flutter.dart';

class Foo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CountdownFormatted countdownFormatted = CountdownFormatted(

      //May need key in stateless widgets
      key: UniqueKey(),
      duration: Duration(hours: 1),
      onFinish: () {
        print('finished!');
      },
      builder: (BuildContext ctx, String remaining) {
        return Text(remaining); // 01:00:00
      },
    );

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          countdownFormatted,
          RaisedButton(
            onPressed: () => countdownFormatted.reset(Duration(seconds: 5)),
            child: Text('Reset (Override duration to 5 seconds)'),
          ),
          RaisedButton(
            onPressed: countdownFormatted.resume,
            child: Text('Resume'),
          ),
          RaisedButton(
            onPressed: countdownFormatted.pause,
            child: Text('Pause'),
          ),
        ],
      ),
    );
  }
}

```

#### Warning
The methods (reset, resume, pause) are written synchronously. This is most noticable if you repeatedly click "resume," where you can see the timer stop until the click action is terminated.
