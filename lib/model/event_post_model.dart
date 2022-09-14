import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hulace/utils/constants.dart';
class PostModel{
  String id,title,url,userId,packageId;
  int timestamp;





  PostModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        title = map['title']??"",
        userId = map['userId']??"",
        packageId = map['packageId']??"",
        timestamp = map['timestamp']??0,
        url = map['url']??"";



  PostModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}