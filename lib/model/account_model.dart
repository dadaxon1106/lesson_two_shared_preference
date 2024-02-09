class Account{
  String? name;
  String? email;
  String? mobileNumber;
  String? password;
  String? confirmPassword;

  Account({required this.name,required this.email,required this.mobileNumber, required this.password, required this.confirmPassword});

  Account.fromJson(Map<String,dynamic> json){
    name = json['name'];
    email = json['email'];
    mobileNumber = json['number'];
    password = json['password'];
    confirmPassword = json['confirm'];
  }
  Map<String,dynamic> toJson(){
    return {
      "name":name,
      "email":email,
      "number":mobileNumber,
      "password":password,
      "confirm password":confirmPassword
    };
  }
}