
class LoginResponseModel {
  final String userId;
  final String employeeId;
  final String orgId;
  final String userName;
  final String email;
  final String role;
  final String token;
  final DateTime expiresAt;
  final String fullName;
  final String organizationName;

  const LoginResponseModel({
    required this.userId,
    required this.employeeId,
    required this.orgId,
    required this.userName,
    required this.email,
    required this.role,
    required this.token,
    required this.expiresAt,
    required this.fullName,
    required this.organizationName,
  });

  factory LoginResponseModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return LoginResponseModel(
      userId: json['userId'] as String,
      employeeId: json['employeeId'] as String,
      orgId: json['orgId'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      token: json['token'] as String,
      expiresAt: DateTime.parse(
        json['expiresAt'] as String,
      ),
      fullName: json['fullName'] as String,
      organizationName:
      json['organizationName'] as String,
    );
  }
}
