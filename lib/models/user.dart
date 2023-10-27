class User {
  int? id;
  String? fullname;
  String? image;
  String? email;
  String? token;

  // constructor
  User({this.id, this.image, this.fullname, this.email, this.token});

  // function to convert json data to user model
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        fullname: json['user']['fullname'],
        image: json['user']['image'],
        email: json['user']['email'],
        token: json['token']);
  }
}
