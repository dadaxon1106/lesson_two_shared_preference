class User {

  String? email;
  String? password;

  User( this.email, this.password);

  User.fromJson(Map<String,dynamic> json) {
    email = json['email'];
    password = json['password'];
  }
  Map<String,dynamic> toJson(){
    return {
      "email":email,
      "password":password
    };
  }
}
