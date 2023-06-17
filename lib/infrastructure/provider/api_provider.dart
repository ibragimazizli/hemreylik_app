import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:hemreyliyin_sesi/infrastructure/api_service/api_services.dart';
import 'package:hemreyliyin_sesi/models/otp_fail.dart';
import 'package:hemreyliyin_sesi/models/otp_success.dart';
import 'package:hemreyliyin_sesi/models/register_error.dart';

import '../../models/profile_add.dart';
import '../../models/register_model.dart';

class ApiProvider extends ChangeNotifier {
  bool isLoading = false;
  SuccessResponse? _successResp;
  SuccessResponse? get succcessResp => _successResp;
  ErrorResponse? _errorResponse;
  RegisterSuccessfulResponse? _data;
  RegisterSuccessfulResponse? get data => _data;
  ApiResponse? _register;
  ApiResponse? get register => _register;

  String? message;
  bool isEmpty = false;

  String baseUrl = 'https://hemreylik.in4tech.az/api';
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  };

  Future<Object> sendApiRequest({required String phone}) async {
    var body = jsonEncode({'phone': phone});

    var response = await http.post(Uri.parse('$baseUrl/send-otp'),
        headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return SuccessResponse.fromJson(data);
    } else {
      var data = jsonDecode(response.body);
      message = data["message"];
      return ErrorResponse.fromJson(data);
    }
  }

  Future<ApiResponse> registerUser(
      {required String phone, required String code}) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'phone': phone, 'code': code});

    final response = await http.post(Uri.parse('$baseUrl/register'),
        headers: headers, body: body);

    if (response.statusCode == 201) {
      return RegisterSuccessfulResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 422) {
      return RegisterErrorResponse.fromJson(jsonDecode(response.body));
    } else {
      return ApiResponse(
          message: "Telefon nömrənisi hal-hazırda bazada mövcuddur.");
    }
  }

  Future<UserApiResponse> sendUserRequest({
    required String name,
    required String surname,
    required String birthday,
    required int gender,
    required String phone,
    required String token,
  }) async {
    var heaheaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final body = jsonEncode({
      'name': name,
      'surname': surname,
      'birthday': birthday,
      'gender': gender,
      'phone': phone,
    });

    final response = await http.post(Uri.parse('$baseUrl/set-info'),
        headers: heaheaders, body: body);

    if (response.statusCode == 201) {
      return UserSuccessResponse.fromJson(jsonDecode(response.body));
    } else {
      return UserErrorResponse.fromJson(jsonDecode(response.body));
    }
  }
}
