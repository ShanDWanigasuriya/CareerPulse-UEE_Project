class Member {
  final int? memberId;  // Can be nullable since memberId might not exist before registration
  final String userName;
  final String password;
  final String email;
  final String fullName;
  final int? memberType; // Make memberType nullable
  final bool isActive;

  Member({
    this.memberId, // Nullable for initial registration
    required this.userName,
    required this.password,
    required this.email,
    required this.fullName,
    this.memberType, // Allow memberType to be null
    required this.isActive,
  });

  // Factory constructor for creating a new Member object from JSON
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      memberId: json['memberId'],
      userName: json['userName'],
      password: '', // Exclude password from response JSON for security
      email: json['email'],
      fullName: json['fullName'],
      memberType: json['memberType'] != null ? json['memberType'] as int : null, // Safely handle null
      isActive: json['isActive'],
    );
  }

  // Convert the Member object into JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'userName': userName,
      'password': password, // Include password for registration or login
      'email': email,
      'fullName': fullName,
      'memberType': memberType,
      'isActive': isActive,
    };
  }
}
