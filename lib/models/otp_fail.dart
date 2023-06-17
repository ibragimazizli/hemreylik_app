// To parse this JSON data, do
//
//     final otpFailure = otpFailureFromJson(jsonString);

import 'dart:convert';

OtpFailure otpFailureFromJson(String str) =>
    OtpFailure.fromJson(json.decode(str));

String otpFailureToJson(OtpFailure data) => json.encode(data.toJson());

class OtpFailure {
  String message;
  Errors errors;

  OtpFailure({
    required this.message,
    required this.errors,
  });

  factory OtpFailure.fromJson(Map<String, dynamic> json) => OtpFailure(
        message: json["message"],
        errors: Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errors": errors.toJson(),
      };
}

class Errors {
  List<String> phone;

  Errors({
    required this.phone,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        phone: List<String>.from(json["phone"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "phone": List<dynamic>.from(phone.map((x) => x)),
      };
}
