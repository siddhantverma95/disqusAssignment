class LoginEntity {
  String username;
  String password;
  String image;
  String emailId;

  LoginEntity({this.username, this.password, this.image, this.emailId});

  LoginEntity.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    image = json['image'];
    emailId = json['emailId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['image'] = this.image;
    data['emailId'] = this.emailId;
    return data;
  }
}