class Message{

  int id; 
  int contactID; 
  DateTime dateTime; 
  String type;
  String message; 
  bool selected=false;
  Message(
    {
      required this.id, 
      required this.contactID, 
      required this.dateTime, 
      required this.type, 
      required this.message
    });
  Message.fromJson(Map<String,dynamic> json):
    id=json['id'],
    contactID=json['contactID'],
    dateTime=DateTime.parse(json['date']),
    type=json['type'],
    message=json['message'];
  Map toJson()=> {
    'id':id,
    'contactID':contactID,
    'message':message,
    'type':type,
    'date':dateTime.toString()
};
}