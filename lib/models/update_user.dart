class UpdateUser {
  UpdateUser({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.token,
    required this.address,
    required this.imageName,
    required this.imagePath,
    required this.oldPassword,
    required this.newPassword,
  });

  final int? id;
  final String email;
  final String firstName;
  final String lastName;
  final String? token;
  final String address;
  final String imageName;
  final String imagePath;
  final String oldPassword;
  final String newPassword;

  factory UpdateUser.fromJson(Map<String, dynamic> json) => UpdateUser(
        id: json['user_id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        token: json['token'],
        address: json['address'],
        imageName: json['image_name'],
        imagePath: json['image_path'],
        oldPassword: json['old_password'],
        newPassword: json['new_password'],
      );

  UpdateUser copyWith(
          {String? id,
          String? firstName,
          String? lastName,
          String? email,
          String? address,
          String? imageName,
          String? imagePath,
          String? oldPassword,
          String? newPassword,
          String? token}) =>
      UpdateUser(
          email: email ?? this.email,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          imageName: imageName ?? this.imageName,
          imagePath: imagePath ?? this.imagePath,
          address: address ?? this.address,
          oldPassword: oldPassword ?? this.oldPassword,
          newPassword: newPassword ?? this.newPassword,
          token: token ?? this.token);
}
