import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hulace/screens/customer/view_vendor.dart';
import 'package:provider/provider.dart';

import '../../api/firebase_apis.dart';
import '../../model/users.dart';
import '../../provider/UserDataProvider.dart';
import '../../utils/constants.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: secondaryColor,

      body: Container(
        margin: EdgeInsets.only(top: 50,left: 10,right: 10),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.08,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.topCenter,
              child: Padding(
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
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                decoration: BoxDecoration(
                    color: bgColor,

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                ),
                child:  FutureBuilder<List<UserModel>>(
                    future: getFavouriteVendors(provider.userData!.favouriteVendors),
                    builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator()
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
                            child: Text("No Vendors"),
                          );
                        }

                        else {

                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context,int index){
                              return Vendors(snapshot.data![index]);
                            },
                          );
                        }
                      }
                    }
                ),

              ),
            )
          ],
        ),
      ),
    );
  }
  Widget Vendors(UserModel model){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ViewVendor(model)));

      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 10,),
            ListTile(
              leading: model.profilePic==""?
              Container(
                margin: EdgeInsets.all(2),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/images/profile.png",),
                        fit: BoxFit.cover
                    )

                ),

              ):
              Container(
                margin: EdgeInsets.all(2),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(model.profilePic),
                        fit: BoxFit.cover
                    )

                ),

              ),
              title: Text("${model.firstName} ${model.lastName}",style: TextStyle(fontWeight: FontWeight.w500),),
              subtitle: Text("${model.businessName}",style: TextStyle(fontWeight: FontWeight.w300),),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )
              ),
              child:  FutureBuilder<String>(
                  future: getPackages(model.userId),
                  builder: (context, AsyncSnapshot<String> snapshot) {
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


                      else {

                        return Text(snapshot.data!,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 13),);
                      }
                    }
                  }
              ),
            )

          ],
        ),
      ),
    );
  }
}
