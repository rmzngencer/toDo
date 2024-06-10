class User{
  late int user_id;
  late String user_name;
  late String user_email;
  late String user_password;


  User({
    required this.user_id,
    required this.user_name,
    required this.user_email,
    required this.user_password,
  });

  User.fromMap(Map<String, dynamic> map) {
    user_id = map["user_id"];
    user_name = map["user_name"];
    user_email = map["user_email"];
    user_password = map["user_password"];
  }

  Map<String, dynamic> toMap() { 
    return {
      "user_id": user_id,
      "user_name": user_name,
      "user_email": user_email,
      "user_password": user_password,
    };
  }
}