import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ColorfulProgressIndicator extends StatefulWidget {
  final int time;
  const ColorfulProgressIndicator({super.key, required this.time});

  @override
  State<ColorfulProgressIndicator> createState() => _ColorfulProgressIndicatorState();
}

class _ColorfulProgressIndicatorState extends State<ColorfulProgressIndicator> {
  bool _changeColor = true;
  bool _stopProgressIndicator = false;

  int _start = 0;

  @override
  void initState() {
    super.initState();
    _start = widget.time;
    looper();
  }

  void changeColor(bool value) {
    if (mounted) {
      setState(() {
        _changeColor = value;
      });
    }
  }

  void looper() async {
    int counter = 1;
    while (_start > 0) {
      if (counter % 2 == 0) {
        changeColor(true);
      } else {
        changeColor(false);
      }
      await Future.delayed(const Duration(milliseconds: 1000));
      if (mounted) {
        setState(() {
          counter = counter + 1;
          _start = _start - 1;
          debugPrint(counter.toString());
        });
      }
    }
  }

  // void startTimer() {
  //   setState(() {
  //     _stopProgressIndicator = false;
  //   });
  //   const oneSec = Duration(milliseconds: 500);
  //   Timer _timer = Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       if (_start == 0) {
  //         setState(() {
  //           _stopProgressIndicator = true;
  //         });
  //         timer.cancel();
  //       } else {
  //         if (_start % 2 == 0) {
  //           changeColor(true);
  //         } else {
  //           changeColor(false);
  //         }

  //         _start--;
  //       }
  //     },
  //   );
  // }

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
                    _start = widget.time;
                  });
                  // startTimer();
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
