import 'package:cloud_firestore/cloud_firestore.dart';
class PackageModel{
  String id,userId,description,title,image,category,status,budget;
  int createdAt;





  PackageModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        description = map['description']??"",
        image = map['image']??"",
        userId = map['userId']??"",
        category = map['category']??"",
        status = map['status']??"",
        title = map['title']??"",
        budget = map['budget']??"0",
        createdAt = map['createdAt']??DateTime.now().millisecondsSinceEpoch;



  PackageModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}