import 'package:cloud_firestore/cloud_firestore.dart';
class ReviewModel{
  String id,vendorId,customerId,orderId,packageId,review;
  int createdAt;
  var rating;





  ReviewModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        vendorId = map['vendorId']??"",
        customerId = map['customerId']??"",
        packageId = map['packageId']??"",
        orderId = map['orderId']??"",
        review = map['review']??"",
        rating = map['rating']??0,
        createdAt = map['createdAt']??DateTime.now().millisecondsSinceEpoch;



  ReviewModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}