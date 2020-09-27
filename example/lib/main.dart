import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:countdown_flutter/countdown_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Assign countdown to widgets
  Countdown _countdown;
  CountdownFormatted _countdownFormatted;

  var _countdownDone = false;
  var _countdownFormattedDone = false;

  @override
  void initState() {
    super.initState();

    //Initialize Generic Widget
    _countdown = Countdown(
      duration: Duration(seconds: 10),
      onFinish: () {
        setState(() {
          _countdownDone = true;
        });
        print('finished!');
      },
      builder: (BuildContext ctx, Duration remaining) {
        return Text('${remaining.inMinutes}:${remaining.inSeconds}');
      },
    );

    //Initialize Formatted Widget
    _countdownFormatted = CountdownFormatted(
      duration: Duration(hours: 1),
      onFinish: () {
        setState(() {
          _countdownFormattedDone = true;
        });
        print('finished!');
      },
      builder: (BuildContext ctx, String remaining) {
        return Text(
          remaining,
          style: TextStyle(fontSize: 30),
        ); // 01:00:00
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('App'),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceEvenly,
            runAlignment: WrapAlignment.center,
            children: [
              //Generic
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _countdown,
                  RaisedButton(
                    onPressed: () {
                      _countdown.reset();
                      if (_countdownDone) {
                        setState(() => _countdownDone = false);
                      }
                    },
                    child: Text('Reset'),
                  ),
                  RaisedButton(
                    onPressed: _countdown.resume,
                    child: Text('Resume'),
                  ),
                  RaisedButton(
                    onPressed: _countdown.pause,
                    child: Text('Pause'),
                  ),
                  Text(
                    _countdownDone ? 'Finished!' : 'Counting...',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 20),
                  ),
                ],
              ),

              //Formatted
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _countdownFormatted,
                  RaisedButton(
                    onPressed: () {
                      _countdownFormatted.reset(Duration(seconds: 5));
                      if (_countdownFormattedDone) {
                        setState(() => _countdownFormattedDone = false);
                      }
                    },
                    child: Text('Reset (Override duration to 5 seconds)'),
                  ),
                  RaisedButton(
                    onPressed: _countdownFormatted.resume,
                    child: Text('Resume'),
                  ),
                  RaisedButton(
                    onPressed: _countdownFormatted.pause,
                    child: Text('Pause'),
                  ),
                  Text(
                    _countdownFormattedDone ? 'Finished!' : 'Counting...',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
