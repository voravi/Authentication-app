class SignUp {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  SignUp({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory SignUp.fromMap({required Map data}) {
    return SignUp(
      username: data["username"],
      email: data["email"],
      password: data["password"],
      confirmPassword: data["confirmPassword"],
    );
  }

  Map toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
      };
}
