//User file is model which element we see and work on in the API.
class User {
  final int id;
  final String name;
  final String email;
  final String companyName;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.companyName,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      companyName: json['company']['name'],
    );
  }
}
