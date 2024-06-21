class User {
  User({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.token,
  });

  final int? id;
  final String email;
  final String firstName;
  final String lastName;
  final String? token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        token: json['token'],
      );
        
  User copyWith(
          {String? id,
          String? firstName,
          String? lastName,
          String? email,
          String? token}) =>
      User(
          email: email ?? this.email,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          token: token ?? this.token);

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'token': token,
      };
}
