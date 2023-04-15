import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkmyvehicle/Widgets/index.dart';

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({super.key});

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSent = false;

  Future<bool> sendOTP(String emailId) async {
    setState(() {
      _isSent = true;
    });
    await Future.delayed(const Duration(seconds: 30));
    setState(() {
      _isSent = false;
    });
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double height = size.height * 0.5;
    final double width = size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: Center(
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: SizedBox(
            width: 300,
            height: 400,
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: _isSent
                    ? const Center(child: CircularProgressIndicator())
                    : Form(
                        key: _formKey,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            const Text(
                              "Welcome to Park My Vehicle",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Please Enter Email Id",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email address',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email is required';
                                } else if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size>(
                                const Size(200, 60),
                              )),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // Perform the action after validation
                                  String email = _emailController.text;

                                  var data = await sendOTP(email);
                                  if (data) {
                                    Toasts.successToast("Check inbox for OTP");
                                  }
                                  // Do something with the email address
                                }
                              },
                              child: const Text('Get OTP'),
                            ),
                          ],
                        ),
                      )),
          ),
        ),
      ),
    );
  }
}
