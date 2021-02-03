import 'package:flutter/material.dart';

class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation,this.restartTimer}) : super(key: key, listenable: animation);
  Animation<int> animation;
  final Function restartTimer;
 // _MyAppState rs = new _MyAppState();

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return timerText == '0:00'
        ? InkWell(
      child: Text('Resend',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
            fontFamily: 'ProximaSoft',
          )),
      onTap: () {
        this.restartTimer();
      },
    )
        : Text(
      "Resend code in " + "$timerText",
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontFamily: 'ProximaSoft',
      ),
    );
  }
}
