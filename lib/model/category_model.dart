import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hulace/utils/constants.dart';
class CategoryModel{
  String id,name,image;
  int colorCode;





  CategoryModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        name = map['name']??"",
        colorCode = map['colorCode']??primaryColor.value,
        image = map['image']??"";


  CategoryModel(this.id, this.name,this.image,this.colorCode);

  CategoryModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}