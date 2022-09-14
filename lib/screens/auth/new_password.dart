import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/UserDataProvider.dart';
import '../../utils/constants.dart';
import 'login.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);


  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  bool _isObscurePass = true;
  bool _isObscureConfirmPass = true;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final provider = Provider.of<UserDataProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.all(10),
              color: Colors.blue,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back, color: bgColor,)
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text ('Create New Password',style: TextStyle(
                      color: bgColor,
                      fontSize: 18
                    ),),
                  ),
                ],
              ),
            ),
            // Main Container of Screen
            Expanded(
              child: Container(
                  decoration: BoxDecoration(color: bgColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30,),
                      const Center(
                        child: Text("Create New Password", style: TextStyle(
                          color: primaryColor,
                          fontSize: 26,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                      const SizedBox(height: 30,),

                      TextField(
                        obscureText: _isObscurePass,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Password',
                          fillColor: bgColor,
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscurePass ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscurePass = !_isObscurePass;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextField(
                        obscureText: _isObscureConfirmPass,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Confirm Password',
                          fillColor: bgColor,
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscureConfirmPass ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscureConfirmPass = !_isObscureConfirmPass;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Center(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Login()));
                          },
                          child: Container(
                            height: 40,
                            width: width*0.5,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.center,
                            child: const Text("SAVE NEW PASSWORD",style: TextStyle(fontSize:16,color: bgColor),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            ),
          ],
        ),

      ),
    );
  }
}
