class User {
  final String name;
  final String profile;
  final int id;
  
  User(this.name, this.profile, this.id);
  
  User.fromJson(Map<String, dynamic> json) :
      name = json["name"] as String,
      profile = json["profile"] as String,
      id = json["id"] as int;
  
  // https://flutter.io/json/
  Map<String, dynamic> toJson() => {
    "name" : name,
    "profile" : profile,
    "id" : id
  };
}
