class UpdateUser {
  UpdateUser({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.address,
    this.token,
    required this.imageName,
    required this.imagePath,
  });

  final int? id;
  final String email;
  final String firstName;
  final String lastName;
  final String address;
  final String? token;
  final String imageName;
  final String imagePath;

  factory UpdateUser.fromJson(Map<String, dynamic> json) => UpdateUser(
        id: json['user_id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        address: json['address'],
        token: json['token'],
        imageName: json['image_name'],
        imagePath: json['image_path'],
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
          token: token ?? this.token);
}

class UpdatePassword {
  UpdatePassword({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.oldPassword,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  final int? id;
  final String email;
  final String firstName;
  final String lastName;
  final String address;
  final String oldPassword;
  final String newPassword;
  final String newPasswordConfirmation;

  factory UpdatePassword.fromJson(Map<String, dynamic> json) => UpdatePassword(
        id: json['user_id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        address: json['address'],
        oldPassword: json['old_password'],
        newPassword: json['new_password'],
        newPasswordConfirmation: json['new_password_confirmation'],
      );

  UpdatePassword copyWith(
          {String? id,
          String? firstName,
          String? lastName,
          String? email,
          String? address,
          String? oldPassword,
          String? newPassword,
          String? newPasswordConfirmation,
          String? token}) =>
      UpdatePassword(
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        address: address ?? this.address,
        oldPassword: oldPassword ?? this.oldPassword,
        newPassword: newPassword ?? this.newPassword,
        newPasswordConfirmation: newPassword ?? this.newPasswordConfirmation,
      );
}



class ProfileImage {
  final String path;

  ProfileImage({required this.path});

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      path: json['path'],
    );
  }
}
