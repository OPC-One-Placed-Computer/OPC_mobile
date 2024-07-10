class CurrentAuthentication {
  CurrentAuthentication({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.address,
    this.imageName,
    this.imagePath,
    this.token,
  });

  final int? id;
  final String email;
  final String firstName;
  final String lastName;
  final String? address;
  final String? imageName;
  final String? imagePath;
  final String? token;

  factory CurrentAuthentication.fromJson(Map<String, dynamic> json) =>
      CurrentAuthentication(
        id: json['user_id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        address: json['address'],
        imageName: json['image_name'],
        imagePath: json['image_path'],
        token: json['token'],
      );

  CurrentAuthentication copyWith(
          {String? id,
          String? firstName,
          String? lastName,
          String? email,
          String? address,
          String? imageName,
          String? imagePath,
          String? token}) =>
      CurrentAuthentication(
          email: email ?? this.email,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          imageName: imageName ?? this.imageName,
          imagePath: imagePath ?? this.imagePath,
          address: address ?? this.address,
          token: token ?? this.token);

  Map<String, dynamic> toJson() => {
        'user_id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'address': address,
        'token': token,
      };
}
