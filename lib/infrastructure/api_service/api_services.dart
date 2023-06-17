// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:hemreyliyin_sesi/models/otp_fail.dart';
// import 'package:hemreyliyin_sesi/models/otp_success.dart';
// import 'package:hemreyliyin_sesi/models/profile_add.dart';
// import 'package:hemreyliyin_sesi/models/register_error.dart';
// import 'package:http/http.dart' as http;

// import '../../models/register_model.dart';

// class ApiServices {
//   String baseUrl = 'https://hemreylik.in4tech.az/api';
//   var headers = {
//     'Accept': 'application/json',
//     'Content-Type': 'application/json'
//   };
//   String message = "";
//   bool isEmpty = false;

//   Future<Object> sendApiRequest({required String phone}) async {
//     var body = jsonEncode({'phone': phone});

//     var response = await http.post(Uri.parse('$baseUrl/send-otp'),
//         headers: headers, body: body);

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       return SuccessResponse.fromJson(data);
//     } else {
//       var data = jsonDecode(response.body);
//       return ErrorResponse.fromJson(data);
//     }
//   }

//   Future<Register?> register(
//       {required String phone, required String otp}) async {
//     var body = json.encode(
//       {"phone": phone, "code": otp},
//     );
//     final resp = await http.post(Uri.parse('$baseUrl/register'),
//         headers: headers, body: body);
//     try {
//       if (resp.statusCode == 201) {
//         var body = json.decode(resp.body);
//         var data = registerFromJson(json.encode(body));
//         debugPrint(data.message);
//         return data;
//       } else if (resp.statusCode == 422) {
//         message = "Telefon nömrəsi hal hazırda bazada mövcuddur";
//       }
//     } catch (e) {
//       return null;
//     }
//     return null;
//   }

//   Future addInfo({
//     required String name,
//     required String surname,
//     required String birthday,
//     required int sex,
//     required String phone,
//     required String token,
//   }) async {
//     var body = json.encode({
//       "name": name,
//       "surname": surname,
//       "birthday": birthday,
//       "gender": sex,
//       "phone": phone,
//     });
//     var heaheaders = {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $token'
//     };
//     var resp = await http.post(
//       Uri.parse('$baseUrl/set-info'),
//       headers: heaheaders,
//       body: body,
//     );
//     if (resp.statusCode == 201) {
//       var respbody = json.decode(resp.body);
//       var data = profileAddFromJson(json.encode(respbody));
//       return data;
//     }
//   }
// }
