import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'index.dart';
import '../Utils/index.dart';

import 'package:provider/provider.dart';

GetIt locator = GetIt.instance;

class RegistrationService {
  //url = https://jsonplaceholder.typicode.com/todos/1
  // final myProvider = Provider.of<MyProvider>(context);
  final BaseService baseService;

  RegistrationService() : baseService = BaseService(); //dependency Injection

  Future<Map<String, Object>> fetchLoginData(String emailId) async {
    // BaseService baseService = BaseService();
    final response = await baseService.dioInterceptor().get(Urls.baseURL+Urls.sendEmail+emailId);
    Map<String, Object> resp = response.data;
    // debugPrint("Data===>${resp["title"]}");
    return resp;
  }

  Future<Map<String, Object>> verifyOTP(String emailId,String otp) async {
    // BaseService baseService = BaseService();

    final response = await baseService.dioInterceptor().post(Urls.baseURL+Urls.verifyOTP,data: jsonEncode({
      "email":emailId,
      "otp":otp
    }));
    Map<String, Object> resp = response.data;
    // debugPrint("Data===>${resp["title"]}");
    return resp;
  }
}
