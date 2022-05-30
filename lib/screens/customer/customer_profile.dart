import 'package:flutter/material.dart';
import 'package:hulace/utils/constants.dart';
import 'package:hulace/widgets/custom_appbar.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text("Profile",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              ),
              SizedBox(height: 10,),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/person.png"),
                  )
                ),
              ),
              SizedBox(height: 5,),
              Text("William Jones",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              SizedBox(height: 10,),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ListTile(
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
                  leading: Icon(Icons.settings,color: primaryColor,),
                  title: Text("Settings"),
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
                  leading: Icon(Icons.reply,color: primaryColor,),
                  title: Text("Refer a friend"),
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
                  leading: Icon(Icons.headset_mic_rounded,color: primaryColor,),
                  title: Text("Legal & Support"),
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
                  leading: Icon(Icons.login,color: primaryColor,),
                  title: Text("Logout"),
                ),
              ),

              
            ],
          ),
        ),
      ),
    );
  }
}
