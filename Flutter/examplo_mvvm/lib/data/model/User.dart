class User {
  final int id;
  final String name;
  final String lastName;
  final String password;
  final String email;

  User({required this.id, required this.name, required this.lastName, required this.password, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      password: json['password'],
      email: json['email'],
    );
  }
}