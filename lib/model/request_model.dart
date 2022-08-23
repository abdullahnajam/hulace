import 'package:cloud_firestore/cloud_firestore.dart';
class RequestModel{
  String id,userId,description,budget,category,status,date,title;
  int createdAt,dateTime;
  GeoPoint coordinates;





  RequestModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        description = map['description']??"",
        title = map['title']??"title",
        budget = map['budget']??"",
        userId = map['userId']??"",
        category = map['category']??"",
        status = map['status']??"",
        date = map['date']??"",
        coordinates = map['coordinates']??GeoPoint(0,0),
        createdAt = map['createdAt']??DateTime.now().millisecondsSinceEpoch,
        dateTime = map['dateTime']??DateTime.now().millisecondsSinceEpoch;



  RequestModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}