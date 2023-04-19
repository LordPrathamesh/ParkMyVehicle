import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  bool _changeColor = true;
  bool _stopProgressIndicator = false;

  int _start = 20;

  @override
  void initState() {
    super.initState();
    looper();
  }

  void changeColor(bool value) {
    setState(() {
      _changeColor = value;
    });
  }

  void looper() async {
    int counter = 1;
    while (true) {
      if (counter % 2 == 0) {
        changeColor(true);
      } else {
        changeColor(false);
      }
      await Future.delayed( const Duration(milliseconds: 1000));
      setState(() {
        counter=counter+1;
        debugPrint(counter.toString());
      });
    }
  }

  void startTimer() {
    setState(() {
      _stopProgressIndicator = false;
    });
    const oneSec = Duration(milliseconds: 500);
    Timer _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _stopProgressIndicator = true;
          });
          timer.cancel();
        } else {
          if (_start % 2 == 0) {
            changeColor(true);
          } else {
            changeColor(false);
          }

          _start--;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: Center(
        child: _stopProgressIndicator
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _start = 20;
                  });
                  startTimer();
                },
                icon: const Icon(Icons.refresh))
            : Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 4.0,
                    valueColor: _changeColor
                        ? const AlwaysStoppedAnimation<Color>(Colors.purple)
                        : const AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 244, 146, 54)),
                  ),
                  // Icon(
                  //   Icons.ac_unit,
                  //   size: 50.0,
                  //   color: Colors.red,
                  // ),
                ],
              ),
      ),
    );
  }
}
