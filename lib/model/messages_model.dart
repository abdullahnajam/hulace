import 'package:cloud_firestore/cloud_firestore.dart';
class MessagesModel{
  String id,senderId,recieverId,message,mediaType,headId;
  bool isRead;
  int sentAt;





  MessagesModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        senderId = map['senderId']??"",
        message = map['message']??"",
        headId = map['headId']??"",
        mediaType = map['mediaType']??"",
        isRead = map['isRead']??"",
        sentAt = map['sentAt']??DateTime.now().millisecondsSinceEpoch,
        recieverId = map['recieverId']??"";


  MessagesModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}