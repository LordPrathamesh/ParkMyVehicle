import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:parkmyvehicle/Widgets/index.dart';
import '../Utils/index.dart';
import '../Services/index.dart';
import 'index.dart';

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({super.key});

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final RegistrationService _registrationService;
  // RegistrationService() : baseService = BaseService();
  _RegisterationScreenState()
      : _registrationService = RegistrationService(); //dependency Injection

  final _emailController = TextEditingController();
  final _otpControllers = List.generate(4, (i) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  bool _isSent = false;
  bool _isChangeEmail = false;

  Future<bool> sendOTP() async {
    debugPrint(_emailController.text);
    setState(() {
      _otpControllers.forEach((element) {
        element.text = "";
      });
      _isSent = true;
      _isChangeEmail = true;
    });
    await Future.delayed(const Duration(seconds: 5));
    // var resp = await _registrationService.fetchLoginData(_emailController.text);
    // Toasts.successToast(resp["title"].toString());

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Card(
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: _isChangeEmail
                                    ? [
                                        const Text("Enter OPT",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 20),
                                        const Divider(color: Colors.white),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: List.generate(4, (index) {
                                            return SizedBox(
                                              width: 50,
                                              child: TextFormField(
                                                controller:
                                                    _otpControllers[index],
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.blue),
                                                maxLength: 1,
                                                decoration:
                                                    const InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  counterText: "",
                                                  border: OutlineInputBorder(),
                                                ),
                                                validator: (value) {
                                                  if (value != null &&
                                                      value.isEmpty) {
                                                    return Messages
                                                        .optValidation1;
                                                  } else if (value != null &&
                                                      value.length > 1) {
                                                    return Messages
                                                        .optValidation2;
                                                  }
                                                  return null;
                                                },
                                                onChanged: (value) {
                                                  if (value.isNotEmpty) {
                                                    FocusScope.of(context)
                                                        .nextFocus();
                                                  } else {
                                                    FocusScope.of(context)
                                                        .previousFocus();
                                                  }
                                                },
                                              ),
                                            );
                                          }),
                                        ),
                                        const SizedBox(height: 5),
                                        const Divider(color: Colors.white),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  sendOTP();
                                                },
                                                child: const Text(
                                                  "Resend OTP",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    String otp = _otpControllers
                                                        .map((controller) =>
                                                            controller.text)
                                                        .join();
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const LocationSelectorScreen()),
                                                    );
                                                    // TODO: Validate the OTP against a server or other source.
                                                    // var resp =
                                                    //     await _registrationService
                                                    //         .fetchLoginData();
                                                    // Toasts.successToast(
                                                    //     resp["title"]
                                                    //         .toString());
                                                  }
                                                },
                                                child: const Text(
                                                  "Submit",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _isChangeEmail = false;
                                                  });
                                                },
                                                child: const Text(
                                                  "Change Email",
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]
                                    : [
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
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: const InputDecoration(
                                            // filled: true,
                                            // fillColor: Colors.grey,
                                            labelText: 'Email',
                                            hintText:
                                                'Enter your email address',
                                            border: OutlineInputBorder(),
                                            // labelStyle:
                                            //     TextStyle(color: Colors.black),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return Messages.emailValidation1;
                                            } else if (!RegExp(
                                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                .hasMatch(value)) {
                                              return Messages.emailValidation2;
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16.0),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              fixedSize: MaterialStateProperty
                                                  .all<Size>(
                                            const Size(200, 60),
                                          )),
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // Perform the action after validation
                                              String email =
                                                  _emailController.text;

                                              var data = await sendOTP();
                                              if (data) {
                                                Toasts.successToast(
                                                    "Check inbox for OTP");
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
              const Divider(color: Colors.white, thickness: 2.0),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "About Us:",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: const [
                        Expanded(
                            child: Text(
                                "1. Welcome to Park My Vehicle, the innovative solution to your parking problems. Our mission is to make finding and reserving parking easy and convenient, so you can focus on what matters most to you."))
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: const [
                        Expanded(
                            child: Text(
                                "2. Welcome to Park My Vehicle, the innovative solution to your parking problems. Our mission is to make finding and reserving parking easy and convenient, so you can focus on what matters most to you."))
                      ],
                    ),
                    Row(
                      children: const [
                        Expanded(
                            child: Text(
                                "3. Welcome to Park My Vehicle, the innovative solution to your parking problems. Our mission is to make finding and reserving parking easy and convenient, so you can focus on what matters most to you."))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
