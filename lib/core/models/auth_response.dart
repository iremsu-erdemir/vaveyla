class AuthResponse {
  const AuthResponse({
    required this.userId,
    required this.roleId,
    required this.fullName,
  });

  final String userId;
  final int roleId;
  final String fullName;

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      userId: json['userId']?.toString() ?? '',
      roleId: _parseInt(json['role']),
      fullName: json['fullName']?.toString() ?? '',
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
