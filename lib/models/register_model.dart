class ApiResponse {
  final String message;

  ApiResponse({required this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'],
    );
  }
}

class RegisterSuccessfulResponse extends ApiResponse {
  final String token;

  RegisterSuccessfulResponse({required String message, required this.token})
      : super(message: message);

  factory RegisterSuccessfulResponse.fromJson(Map<String, dynamic> json) {
    return RegisterSuccessfulResponse(
      message: json['message'],
      token: json['token'],
    );
  }
}

class RegisterErrorResponse extends ApiResponse {
  final Map<String, dynamic> errors;

  RegisterErrorResponse({required String message, required this.errors})
      : super(message: message);

  factory RegisterErrorResponse.fromJson(Map<String, dynamic> json) {
    return RegisterErrorResponse(
      message: json['message'],
      errors: Map<String, dynamic>.from(json['errors']),
    );
  }
}
