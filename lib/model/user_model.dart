class UserModel{
  late String user_name;
  late String password;
  late String email;
  late String phone;


  UserModel (this.user_name, this.password, this.email, this.phone);

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'user_name': user_name,
      'password': password,
      'email': email,
      'phone': phone
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map){
    user_name = map['user_name'];
    password = map['password'];
    email = map['email'];
    phone = map['phone'];
  }
}