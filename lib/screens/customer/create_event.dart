import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:hulace/api/firebase_apis.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../api/image_api.dart';
import '../../model/category_model.dart';
import '../../utils/constants.dart';
import '../../utils/location.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  var _descriptionController=TextEditingController();
  var _dateTimeController=TextEditingController();
  var _locationController=TextEditingController();
  var _codeController=TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int dateInMilli=DateTime.now().millisecondsSinceEpoch;
  String selectedCategory="";
  GeoPoint geoPoint=GeoPoint(0,0);
  int limit=0;
  String city="";

  int selectedCategoryIndex=-1;
  List<String> selectedServices=[];
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
  List<String> urls=[];


  @override
  void initState() {
    super.initState();
    _codeController.text="CODE : EID${getRandomString(8)}";
  }

  _logoModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.cloud_upload),
                    title: const Text('Upload file'),
                    onTap: () => {
                      ImageHandler.chooseGallery().then((value) async{
                        if(value!=null){
                          String imageUrl=await ImageHandler.uploadImageToFirebase(context, value);
                          setState(() {
                            urls.add(imageUrl);
                          });
                        }

                        Navigator.pop(context);
                      })
                    }),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a photo'),
                  onTap: () => {
                    ImageHandler.chooseCamera().then((value) async{
                      if(value!=null){
                        String imageUrl=await ImageHandler.uploadImageToFirebase(context, value);
                        setState(() {
                          urls.add(imageUrl);
                        });
                      }

                      Navigator.pop(context);
                    })
                  },
                ),
              ],
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      //backgroundColor: Colors.pinkAccent,
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

              /*InkWell(
                onTap: (){
                  _logoModalBottomSheet(context);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height*0.25,
                  width: MediaQuery.of(context).size.width,
                  color: secondaryColor,
                  child: photoUrl==""?DottedBorder(
                      color: primaryColor,
                      strokeWidth: 1,
                      dashPattern: [7],
                      borderType: BorderType.Rect,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/upload.png",color: primaryColor,height: 50,width: 50,fit: BoxFit.cover,),
                            SizedBox(height: 10,),
                            Text("Upload Image",style: TextStyle(color: primaryColor,fontWeight: FontWeight.w300),)
                          ],
                        ),
                      )
                  ):Image.network(photoUrl,fit: BoxFit.cover,),
                ),
              ),*/

              SizedBox(height: 10,),
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
                      ListTile(

                        title: const Text("Upload photo or video",style: TextStyle(fontSize:15,fontWeight: FontWeight.w400),),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      Container(
                        height: 100,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (){
                                _logoModalBottomSheet(context);
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                margin: const EdgeInsets.only(right: 10),
                                color: primaryColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/upload.png",height: 30,color: Colors.white,),
                                    const SizedBox(height: 5,),
                                    const Text("Camera",style: TextStyle(fontSize:15,color: Colors.white,fontWeight: FontWeight.w300),),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: urls.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context,int index){
                                  return  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Image.network(urls[index],height: 100,width: 100,fit: BoxFit.cover,),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: _codeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        readOnly: true,
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
                          hintText: '',
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
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime(2100, 6, 7),
                              onChanged: (date) {
                                print('change $date');
                              },
                              onConfirm: (date) {
                                _dateTimeController.text=dtf.format(date);
                                dateInMilli=date.millisecondsSinceEpoch;
                              },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en
                          );
                        },
                        controller: _dateTimeController,
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
                        controller: _descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
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
                            city=result.addressComponents![2].longName;
                            geoPoint=GeoPoint(result.geometry!.location.lat, result.geometry!.location.lng);
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Bussiness Categories",style: TextStyle(fontSize:18,fontWeight: FontWeight.w500),),

                          ],
                        ),
                      ),
                      FutureBuilder<List<CategoryModel>>(
                          future: getServices(),
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
                                  child: Text("No Business Categories"),
                                );
                              }

                              else {

                                return Wrap(
                                  spacing: 5,
                                  children: List.generate(
                                    snapshot.data!.length,
                                        (index) {
                                      return FilterChip(
                                        label: Text(snapshot.data![index].name,style: TextStyle(color: selectedServices.contains(snapshot.data![index].name)?Colors.white:Colors.black,),),
                                        backgroundColor: selectedServices.contains(snapshot.data![index].name)?primaryColor:Colors.white,

                                        onSelected: (bool value) {
                                          if(selectedServices.contains(snapshot.data![index].name)){
                                            setState(() {

                                              selectedServices.remove(snapshot.data![index].name);
                                            });
                                          }
                                          else{
                                            setState(() {

                                              selectedServices.add(snapshot.data![index].name);
                                            });
                                          }

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

                      Container(
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text("LIMIT",style: TextStyle(color: Colors.white,fontSize: 16),),
                                    SizedBox(height: 5,),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: bgColor,
                                        borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                limit++;
                                              });
                                            },
                                            child: Container(
                                              height: 35,
                                              child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(150)
                                                  ),
                                                  elevation: 3,
                                                  child: CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      child:  Icon(Icons.add,color: primaryColor,size: 13,)
                                                  )
                                              ),
                                            ),
                                          ),
                                          Text("$limit"),
                                          InkWell(
                                            onTap: (){
                                              if(limit>1){
                                                setState(() {
                                                  limit--;
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: 35,
                                              child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(150)
                                                  ),
                                                  elevation: 3,
                                                  child: CircleAvatar(
                                                      backgroundColor: Colors.white,
                                                      child:  Icon(Icons.remove,color: primaryColor,size: 13,)
                                                  )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: ()async{
                                    if(_formKey.currentState!.validate()){
                                      final ProgressDialog pr = ProgressDialog(context: context);
                                      pr.show(max: 100, msg: 'Please Wait');

                                      await FirebaseFirestore.instance.collection('events').add({
                                        "image":urls,
                                        "limit":limit,
                                        "members":[],
                                        "userId":FirebaseAuth.instance.currentUser!.uid,
                                        "description":_descriptionController.text,
                                        "status":"Active",
                                        "category":selectedCategory,
                                        "date":df.format(DateTime.fromMillisecondsSinceEpoch(dateInMilli)),
                                        "time":tf.format(DateTime.fromMillisecondsSinceEpoch(dateInMilli)),
                                        "location":_locationController.text,
                                        "createdAt":DateTime.now().millisecondsSinceEpoch,
                                        "dateTime":dateInMilli,
                                        "coordinates": geoPoint,
                                        "city": city,
                                        "eventCode": _codeController.text,
                                        "services":selectedServices
                                      }).then((val)async{
                                        pr.close();
                                        CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.success,
                                            text: "Event Created",
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
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    alignment: Alignment.center,
                                    child: Text("POST",),
                                  ),
                                )
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 50,),
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
