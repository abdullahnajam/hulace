import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel{
  String userId,email,password,status,token,type;
  String firstName,lastName,city,country,location,profilePic,age;
  int createdAt,balance;

  String businessName,employeeCount,ssm,businessCategory;



  UserModel.fromMap(Map<String,dynamic> map,String key)
      : userId=key,
        email = map['email']??"",
        password = map['password']??"",
        type = map['type']??"Personal",
        status = map['status']??"",
        firstName = map['firstName']??"",
        lastName = map['lastName']??"",
        city = map['city']??"",
        country = map['country']??"",
        location = map['location']??"",
        profilePic = map['profilePic']??"",
        age = map['age']??"",
        balance = map['balance']??0,
        createdAt = map['createdAt']??DateTime.now().millisecondsSinceEpoch,
        businessName = map['businessName']??"",
        employeeCount = map['employeeCount']??"",
        ssm = map['ssm']??"",
        businessCategory = map['businessCategory']??"",
        token = map['token']??"";



  UserModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}