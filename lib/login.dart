//Wap in Flutter To Design Login With Database
import 'package:flutter/material.dart';
import 'package:login_database/dbhelper.dart';
import 'package:login_database/signup.dart';

import 'homescreen.dart';
main(){
  runApp(My_App());
}
class My_App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Login(),
    );
  }
}
class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>LoginPage();
}
class LoginPage extends State<Login>{
  var username=TextEditingController();
  var password=TextEditingController();
  DbHelper myDb=DbHelper.instance;
  List<Map<String,dynamic>> UserData=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32,color: Colors.blue)),
          Padding(
            padding: const EdgeInsetsDirectional.only(start:30,bottom: 30,end: 30,top:20),
            child: TextField(
              controller: username,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start:30,bottom: 30,end: 30),
            child: TextField(
              controller: password,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
            ),
          ),
          Stack(
            children:[
              InkWell(
                onTap:()async{
                  var values=await myDb.CheckLogin(username.text.toString(), password.text.toString());
                  if(values.isNotEmpty){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  }
                  else if(values.isEmpty){
                    return showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('Enter Username and Password'),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text('Ok'))
                        ],
                      );
                    }
                    );
                  }
                  else{
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('Invalid Username and Password'),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text('Ok'))
                        ],
                      );
                    });
                  }
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top:13,start:70),
                child: Text('LOGIN',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
              )
            ]
          ),
          SizedBox(height: 10),
          Stack(
              children:[
                InkWell(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                  },
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black12
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top:13,start:70),
                  child: InkWell(onTap:(){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUp()));
                  },
                      child: Text('SIGNUP',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                )
              ]
          )
        ],
      ),
    );
  }
  void getdata()async{
    var detail=await myDb.CheckLogin(username.text.toString(), password.text.toString());
    if(detail.isNotEmpty){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
    else if(detail.isEmpty){
      return showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
         title: Text('Enter Username and Password'),
         actions: [
           TextButton(onPressed: (){
             Navigator.pop(context);
           }, child: Text('Ok'))
         ],
        );
      });
    }
    else{
      return showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Ok'),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Ok'))
          ],
        );
      });
    }
  }
}