import 'package:cloud_firestore/cloud_firestore.dart';
class NotificationModel{
  String id,title,body,userId,senderId,subjectId,type;
  int timestamp;
  bool isRead,action;


  NotificationModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        title = map['title']??"",
        senderId = map['senderId']??"",
        userId = map['userId']??"",
        subjectId = map['subjectId']??"",
        type = map['type']??"",
        isRead = map['isRead']??false,
        action = map['action']??true,
        timestamp = map['timestamp']??DateTime.now().millisecondsSinceEpoch,
        body = map['body']??"";


  NotificationModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}