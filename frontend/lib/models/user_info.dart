class UserInfo {
  UserInfo({
    required this.email,
    required this.name,
    required this.surname,
    required this.balance,
    required this.id,
  });

  final String email;
  final String name;
  final String surname;
  final double balance;
  final String id;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        email: json["email"],
        name: json["name"],
        surname: json["surname"],
        balance: json["balance"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "surname": surname,
        "balance": balance,
        "id": id,
      };
}
