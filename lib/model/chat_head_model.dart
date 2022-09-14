import 'package:cloud_firestore/cloud_firestore.dart';
class ChatHeadModel{
  String id,customerId,vendorId;
  String lastMessage;
  int timestamp;





  ChatHeadModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        customerId = map['customerId']??"",
        lastMessage = map['lastMessage']??"Unable to get message",
        timestamp = map['timestamp']??DateTime.now().millisecondsSinceEpoch,
        vendorId = map['vendorId']??"";


  ChatHeadModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}