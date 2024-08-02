class Contact{
  int id;
  String name;
  String profile;
  String type;
  int score;
  Contact.fromJson(Map<String,dynamic> json):
    id=json['id'],
    name=json['name'],
    profile=json['profile'],
    type=json['type'],
    score=json['score'];

}