class NotificationModel{
  String? senderId;
  String? senderName;
  String? action;
  String? time;
  String? reciverId;
  String? senderImage ;
  bool? seen;
  String? targetPostUid;

  NotificationModel({this.action,this.targetPostUid,this.seen,this.reciverId,this.senderId,this.time,this.senderName,this.senderImage});

  NotificationModel.fromJson(Map<String,dynamic>json)
  {
    senderId = json['senderId'];
    senderName = json['senderName'];
    action = json['action'];
    time = json['time'];
    senderImage = json['senderImage'];
    reciverId = json['reciverId'];
    seen = json['seen'];
    targetPostUid = json['targetPostUid'];
  }

  Map<String,dynamic> toMap()
  {
    return{
      'senderId':senderId,
      'reciverId':reciverId,
      'action':action,
      'time':time,
      'senderName':senderName,
      'senderImage':senderImage,
      'seen': seen,
      'targetPostUid': targetPostUid
    };
  }

}