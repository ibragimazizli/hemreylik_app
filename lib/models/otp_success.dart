class SuccessResponse {
  final String status;
  final String message;

  SuccessResponse({required this.status, required this.message});

  factory SuccessResponse.fromJson(Map<String, dynamic> json) {
    return SuccessResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}

class ErrorResponse {
  final String message;
  final Map<String, dynamic> errors;

  ErrorResponse({required this.message, required this.errors});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'],
      errors: json['errors'],
    );
  }
}
