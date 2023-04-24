// import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:parkmyvehicle/Screens/index.dart';
import 'Widgets/index.dart';
import 'Utils/index.dart';

class TreeWidget extends StatefulWidget {
  const TreeWidget({super.key});

  @override
  State<TreeWidget> createState() => _TreeWidgetState();
}

class _TreeWidgetState extends State<TreeWidget> {
  bool _isLoading = true;
  bool _isConnectivty = false;

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
  }

  Future<void> checkInternetConnectivity() async {
    debugPrint("==Checking Connectivity==");
    await Future.delayed(const Duration(seconds: 5));
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet ||
        connectivityResult == ConnectivityResult.other) {
      setState(() {
        _isLoading = false;
        _isConnectivty = true;
      });
      // return true;
    } else {
      Toasts.failToast(Messages.noConnectivity);
      setState(() {
        _isLoading = false;
        _isConnectivty = false;
      });

      // return true;
    }
    debugPrint("====Connectivity===${_isConnectivty.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        body: _isLoading
            ? const Center(
                child: ColorfulProgressIndicator( time: 5,),
              )
            : _isConnectivty
                ? const RegisterationScreen()
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.signal_wifi_off_outlined),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Please Check Connectivity",
                            style: TextStyle(fontSize: 18)),
                        const SizedBox(
                          height: 20,
                        ),
                        IconButton(
                            onPressed: () {
                              checkInternetConnectivity();
                            },
                            icon: const Icon(Icons.refresh)),
                      ],
                    ),
                  ));
  }
}
