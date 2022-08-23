import 'package:cloud_firestore/cloud_firestore.dart';
class OrderModel{
  String id,vendorId,customerId,budget,category,status,date,time,packageId,paymentStatus;
  int createdAt,dateTime;
  bool isRated;
  var rating;





  OrderModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        vendorId = map['vendorId']??"",
        customerId = map['customerId']??"",
        packageId = map['packageId']??"",
        budget = map['budget']??"",
        paymentStatus = map['paymentStatus']??"",
        isRated = map['isRated']??false,
        category = map['category']??"",
        status = map['status']??"",
        date = map['date']??"",
        time = map['time']??"",
        rating = map['rating']??0,
        createdAt = map['createdAt']??DateTime.now().millisecondsSinceEpoch,
        dateTime = map['dateTime']??DateTime.now().millisecondsSinceEpoch;



  OrderModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}