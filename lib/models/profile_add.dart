class UserApiResponse {
  final String message;
  final String? status;

  UserApiResponse({required this.message, this.status});

  factory UserApiResponse.fromJson(Map<String, dynamic> json) {
    return UserApiResponse(
      message: json['message'],
      status: json['status'],
    );
  }
}

class UserSuccessResponse extends UserApiResponse {
  UserSuccessResponse({required String message, String? status})
      : super(message: message, status: status);

  factory UserSuccessResponse.fromJson(Map<String, dynamic> json) {
    return UserSuccessResponse(
      message: json['message'],
      status: json['status'],
    );
  }
}

class UserErrorResponse extends UserApiResponse {
  UserErrorResponse({required String message}) : super(message: message);

  factory UserErrorResponse.fromJson(Map<String, dynamic> json) {
    return UserErrorResponse(
      message: json['message'],
    );
  }
}
