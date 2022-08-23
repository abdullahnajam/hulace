import 'package:cloud_firestore/cloud_firestore.dart';
class ProposalModel{
  String id,requestId,customerId,vendorId,cover,cost,status;
  int createdAt;
  bool availability;




  ProposalModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        requestId = map['requestId']??"",
        customerId = map['customerId']??"",
        vendorId = map['vendorId']??"",
        cover = map['cover']??"",
        status = map['status']??"",
        availability = map['availability']??"",
        cost = map['cost']??"",
        createdAt = map['createdAt']??DateTime.now().millisecondsSinceEpoch;



  ProposalModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}