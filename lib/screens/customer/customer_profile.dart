import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:hulace/splash.dart';
import 'package:hulace/utils/constants.dart';
import 'package:hulace/widgets/custom_appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../provider/UserDataProvider.dart';
import '../navigators/customer_drawer.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  void _openDrawer () {
    _drawerKey.currentState!.openDrawer();
  }
  File? imagefile;
  String photoUrl="";
  Future uploadImageToFirebase(BuildContext context) async {
    final ProgressDialog pr = ProgressDialog(context: context);
    pr.show(max: 100, msg: 'Please Wait',barrierDismissible: false);
    firebase_storage.Reference firebaseStorageRef = firebase_storage.FirebaseStorage.instance.ref().child('uploads/${DateTime.now().millisecondsSinceEpoch}');
    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(imagefile!);
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then((value)async {
      photoUrl=value;
      print("value $value");
      setState(() {
        final provider = Provider.of<UserDataProvider>(context, listen: false);
        provider.userData!.profilePic=photoUrl;
        pr.close();
      });
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
        "profilePic":photoUrl,
      }).then((val) {
      });
    }).onError((error, stackTrace){
      pr.close();
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: error.toString(),
      );
    });
  }

  void fileSet(File file){
    setState(() {
      if(file!=null){
        imagefile=file;
      }
    });
    uploadImageToFirebase(context);
  }
  Future _chooseGallery() async{
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) => fileSet(File(value!.path)));

  }
  Future _choosecamera() async{
    await ImagePicker().pickImage(source: ImageSource.camera).then((value) => fileSet(File(value!.path)));
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
                      _chooseGallery()
                    }),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a photo'),
                  onTap: () => {
                    _choosecamera()
                  },
                ),
              ],
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context, listen: false);

    return Scaffold(
        key: _drawerKey,
        drawer: CustomerDrawer(),
      backgroundColor: secondaryColor,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.15,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: secondaryColor,

                ),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                        onTap: (){
                          _openDrawer();
                        },
                        child: Image.asset("assets/images/menu.png",color: primaryColor,height: 40,),
                      ),


                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
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
                                      child:  Icon(Icons.settings,color: primaryColor,)
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10,),
                  ],
                ),
              ),
              Expanded(
                //height: MediaQuery.of(context).size.height*0.65,
                //width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(20)
                  ),

                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height*0.1,
              20,
              0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    _logoModalBottomSheet(context);
                  },
                  child: provider.userData!.profilePic==""?Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                        shape: BoxShape.circle,

                    ),
                    child: Icon(Icons.add,size: 50,),
                  ):
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(provider.userData!.profilePic),
                        )
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Text("${provider.userData!.firstName} ${provider.userData!.lastName}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                SizedBox(height: 10,),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                    onTap: (){
                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                          controller: ModalScrollController.of(context),
                          child: Container(
                            height:  MediaQuery.of(context).size.height*0.5,
                            child: ListView(
                              children: [
                                ListTile(
                                  onTap: (){
                                  },
                                  leading: Icon(Icons.email),
                                  title: Text("Email",style: TextStyle(fontWeight: FontWeight.w500),),
                                  subtitle: Text(provider.userData!.email,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 13),),
                                ),
                                ListTile(
                                  onTap: (){
                                  },
                                  leading: Icon(Icons.location_on),
                                  title: Text("Address",style: TextStyle(fontWeight: FontWeight.w500),),
                                  subtitle: Text(provider.userData!.location,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 13),),
                                ),
                                ListTile(
                                  onTap: (){
                                  },
                                  leading: Icon(Icons.person),
                                  title: Text("Age",style: TextStyle(fontWeight: FontWeight.w500),),
                                  subtitle: Text(provider.userData!.age,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300,fontSize: 13),),
                                ),


                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    leading: Icon(Icons.person,color: primaryColor,),
                    title: Text("Personal Info"),
                    trailing: Icon(Icons.arrow_forward_ios_sharp,color: primaryColor,size: 15,),
                  ),
                ),

                SizedBox(height: 5,),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                    leading: Icon(Icons.account_balance_wallet,color: primaryColor,),
                    title: Text("Payment Ways"),
                    trailing: Icon(Icons.arrow_forward_ios_sharp,color: primaryColor,size: 15,),
                  ),
                ),
                SizedBox(height: 5,),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                    onTap: (){
                      share();
                    },
                    leading: Icon(Icons.reply,color: primaryColor,),
                    title: Text("Refer a friend"),
                    trailing: Icon(Icons.arrow_forward_ios_sharp,color: primaryColor,size: 15,),
                  ),
                ),
                SizedBox(height: 5,),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                      onTap: (){


                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: drawerHeadGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Vendor Subscription",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                                  Image.asset("assets/images/crown.png",height: 25,)
                                ],
                              ),
                              SizedBox(height: 10,),
                              Text("\$4.99/month",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                              SizedBox(height: 10,),
                              InkWell(
                                onTap: (){
                                  //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Subscribe()));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.4,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.fromLTRB(20,10,20,10),
                                  decoration: BoxDecoration(
                                      color: secondaryColor,
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Text("SEE DETAILS",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color:Colors.white),),
                                ),
                              ),
                              SizedBox(height: 5,),
                            ],
                          ),
                        ),
                      ),
                    )
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        context.read<UserDataProvider>().increase();
                      },
                      icon: Icon(Icons.add),
                    ),
                    Text(context.watch<UserDataProvider>().count.toString()),
                    IconButton(
                      onPressed: (){
                        context.read<UserDataProvider>().decrease();
                      },
                      icon: Icon(Icons.remove),
                    ),
                  ],
                )



              ],
            ),
          ),
        ],
      )
    );
  }
}
