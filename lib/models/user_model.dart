class UserModel {
  String id;
  String email;
  String token;

  UserModel(this.id, this.email);

  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    id       = parsedJson['id'];
    email    = parsedJson['email'];
    token    = parsedJson['token'];
  }

}