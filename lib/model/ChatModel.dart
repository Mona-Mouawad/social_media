class ChatModel{
  String? senderId;
  String? reciverId;
  String? megessa;
  String? time;


  ChatModel({this.megessa,this.reciverId,this.senderId,this.time});
 
  ChatModel.fromJson(Map<String,dynamic>json)
  {
    senderId = json['senderId'];
    reciverId = json['reciverId'];
    megessa = json['megessa'];
    time = json['time'];

  }
  
  Map<String,dynamic> toMap()
  {
    return{
      'senderId':senderId,
      'reciverId':reciverId,
      'megessa':megessa,
      'time':time,

    };
  }

}