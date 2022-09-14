import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hulace/model/event_model.dart';
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


Future<List<CategoryModel>> getServices()async{
  List<CategoryModel> categories=[];
  await FirebaseFirestore.instance.collection('services').get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      CategoryModel model=CategoryModel.fromMap(data, doc.reference.id);
      categories.add(model);
    });
  });
  return categories;
}

Future<EventModel> getEventData(String id)async{
  EventModel? model;
  await FirebaseFirestore.instance.collection('events')
      .doc(id)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
      model=EventModel.fromMap(data, documentSnapshot.reference.id);
    }
  });
  return model!;
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

Future< List<UserModel>> getFavouriteVendors(List ids)async{
  print("fav ${ids.first}");
  List<UserModel> vendors=[];
  await FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      UserModel model=UserModel.fromMap(data, doc.reference.id);
      if(ids.contains(model.userId)){
        vendors.add(model);
      }
    });
  });
  return vendors;
}
Future<String> getPackages(userId)async{
  List<double> prices=[];
  await FirebaseFirestore.instance.collection('packages').where("userId",isEqualTo:userId).get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      PackageModel model=PackageModel.fromMap(data, doc.reference.id);
      prices.add(double.parse(model.budget));
    });
  });
  print("prices = $prices");
  prices.sort((a, b) => a.compareTo(b));
  if(prices.isEmpty)
    return "No Packages";
  else
    return "Starts From RM${prices.first}";
}

Future<RatingModel> getLatestMessage(String id)async{
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

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

