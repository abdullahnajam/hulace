import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../model/category_model.dart';
import '../../utils/constants.dart';
import '../../utils/location.dart';

class CreateListing extends StatefulWidget {
  const CreateListing({Key? key}) : super(key: key);

  @override
  _CreateListingState createState() => _CreateListingState();
}

class _CreateListingState extends State<CreateListing> {
  var _descriptionController=TextEditingController();
  var _titleController=TextEditingController();
  var _dateController=TextEditingController();
  var _budgetController=TextEditingController();
  var _locationController=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int dateInMilli=DateTime.now().millisecondsSinceEpoch;
  String selectedCategory="";

  int selectedCategoryIndex=-1;
  Future<List<CategoryModel>> getCategories()async{
    List<CategoryModel> categories=[];
    await FirebaseFirestore.instance.collection('categories').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        CategoryModel model=CategoryModel.fromMap(data, doc.reference.id);
        categories.add(model);
      });
    });
    return categories;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(top: 50,left: 10,right: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)
                            ),
                            elevation: 3,
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child:  Icon(Icons.arrow_back,color: primaryColor,)
                            )
                        ),
                      ),
                    ),


                  ],
                ),
              ),

              SizedBox(height: 20,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: bgColor,

                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )
                  ),
                  child: ListView(
                    padding: EdgeInsets.all(10),
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },

                        controller: _titleController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0.5
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0.5,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Enter Title',
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        readOnly: true,
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime(2100, 6, 7),
                              onChanged: (date) {
                                print('change $date');
                              },
                              onConfirm: (date) {
                                _dateController.text=df.format(date);
                                dateInMilli=date.millisecondsSinceEpoch;
                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en
                          );
                        },
                        controller: _dateController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0.5
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0.5,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Enter Date',
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: _descriptionController,
                        minLines: 3,
                        maxLines: 3,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0.5
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0.5,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Enter Description',
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        readOnly: true,
                        onTap: ()async{
                          List coordinates=await getUserCurrentCoordinates();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacePicker(
                                apiKey: kGoogleApiKey,
                                onPlacePicked: (result) {
                                  result.addressComponents!.forEach((element) {print("herereee ${element.longName}");});
                                  print(result.addressComponents!.length);
                                  _locationController.text=result.formattedAddress!;
                                /*  city=result.addressComponents![2].longName;
                                  geoPoint=GeoPoint(result.geometry!.location.lat, result.geometry!.location.lng);*/
                                  Navigator.of(context).pop();
                                },
                                initialPosition: LatLng(coordinates[0], coordinates[1]),
                                useCurrentLocation: true,
                              ),
                            ),
                          );
                        },
                        controller: _locationController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0.5
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0.5,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Enter Location',
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: _budgetController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 0.5
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 0.5,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Enter Budget',
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Category",style: TextStyle(fontSize:18,fontWeight: FontWeight.w500),),

                          ],
                        ),
                      ),
                      FutureBuilder<List<CategoryModel>>(
                          future: getCategories(),
                          builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container(
                                child: Text("-",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300)),
                              );
                            }
                            else {
                              if (snapshot.hasError) {
                                print("error ${snapshot.error}");
                                return const Center(
                                  child: Text("Something went wrong"),
                                );
                              }
                              else if(snapshot.data!.isEmpty){
                                return const Center(
                                  child: Text("No Categories"),
                                );
                              }

                              else {

                                return Wrap(
                                  spacing: 5,
                                  children: List.generate(
                                    snapshot.data!.length,
                                        (index) {
                                      return FilterChip(
                                        label: Text(snapshot.data![index].name,style: TextStyle(color: selectedCategoryIndex==index?Colors.white:Colors.black,),),
                                        backgroundColor: selectedCategoryIndex==index?primaryColor:Colors.white,

                                        onSelected: (bool value) {
                                          setState(() {
                                            selectedCategoryIndex=index;
                                            selectedCategory=snapshot.data![index].name;
                                          });
                                        },
                                      );
                                    },
                                  ),
                                );
                              }
                            }
                          }
                      ),

                      SizedBox(height: 20,),

                      InkWell(
                        onTap: ()async{
                          if(_formKey.currentState!.validate()){
                            final ProgressDialog pr = ProgressDialog(context: context);
                            pr.show(max: 100, msg: 'Please Wait');

                            await FirebaseFirestore.instance.collection('requests').add({

                              /*String userId,description,,,,;
  int ,;
  double ,lang;

*/
                              "userId":FirebaseAuth.instance.currentUser!.uid,
                              "description":_descriptionController.text,
                              "title":_titleController.text,
                              "budget":_budgetController.text,
                              "status":"Active",
                              "category":selectedCategory,
                              "date":_dateController.text,
                              "location":_locationController.text,
                              "createdAt":DateTime.now().millisecondsSinceEpoch,
                              "dateTime":dateInMilli,
                              "coordinates": GeoPoint(0,0),


                            }).then((val)async{
                              pr.close();
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: "Request Posted",
                                onConfirmBtnTap: (){
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                              );





                            }).onError((error, stackTrace){
                              pr.close();
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.error,
                                text: error.toString(),
                              );
                            });
                          }
                        },
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          alignment: Alignment.center,
                          child: Text("POST",style: TextStyle(color: Colors.white),),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
