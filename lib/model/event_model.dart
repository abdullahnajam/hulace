import 'package:cloud_firestore/cloud_firestore.dart';
class EventModel{
  String id,userId,description,location,category,status,date,time,city,eventCode;
  int createdAt,dateTime,limit;
  List members,pending,image,services;
  GeoPoint coordinates;





  EventModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        description = map['description']??"",
        image = map['image']??[],
        userId = map['userId']??"",
        eventCode = map['eventCode']??"",
        location = map['location']??"",
        time = map['time']??"",
        city = map['city']??"",
        members = map['members']??[],
        pending = map['pending']??[],
        services = map['services']??[],
        category = map['category']??"Personal",
        status = map['status']??"",
        date = map['date']??"",
        limit = map['limit']??0,
        coordinates = map['coordinates']??GeoPoint(0,0),
        createdAt = map['createdAt']??DateTime.now().millisecondsSinceEpoch,
        dateTime = map['dateTime']??DateTime.now().millisecondsSinceEpoch;



  EventModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}