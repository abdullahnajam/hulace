import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hulace/model/package_model.dart';

import '../model/category_model.dart';
import '../model/order_model.dart';
import '../model/rating_model.dart';
import '../model/users.dart';

Future<UserModel> getUserData(String id)async{
  UserModel? request;
  await FirebaseFirestore.instance.collection('users')
      .doc(id)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
      request=UserModel.fromMap(data, documentSnapshot.reference.id);
    }
  });
  return request!;
}

Future<PackageModel> getPackageData(String id)async{
  PackageModel? request;
  await FirebaseFirestore.instance.collection('packages')
      .doc(id)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
      request=PackageModel.fromMap(data, documentSnapshot.reference.id);
    }
  });
  return request!;
}

Future<RatingModel> getRating(String id)async{
  RatingModel ratingModel=RatingModel(0, 0.0);
  await FirebaseFirestore.instance.collection('orders').where("isRated",isEqualTo: true).where("vendorId",isEqualTo: id).get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      OrderModel model=OrderModel.fromMap(data, doc.reference.id);
      ratingModel.totalRatings++;
      ratingModel.rating=(ratingModel.rating+model.rating)/2;

    });
  });
  return ratingModel;
}

