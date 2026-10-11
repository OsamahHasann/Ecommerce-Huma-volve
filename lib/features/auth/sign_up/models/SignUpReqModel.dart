// ignore: file_names
class SignUpReqModel {
  String? email;
  String? name;
  String? password;
  String? avatar;

  SignUpReqModel({required this.email, required this.name, required this.password, required this.avatar});

  SignUpReqModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    password = json['password'];
    avatar = json['avatar'];
  }
}