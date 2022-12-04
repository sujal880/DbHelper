//Wap in Flutter To Design SignUp Page
import 'package:flutter/material.dart';
import 'package:login_database/dbhelper.dart';
import 'package:login_database/login.dart';
import 'package:login_database/notemodel.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var name=TextEditingController();
  var password=TextEditingController();
  var phone=TextEditingController();
  DbHelper myDb=DbHelper.instance;
  List<Map<String,dynamic>> UserData=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: name,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.account_circle_sharp),
                  hintText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 20, bottom: 20, end: 20),
            child: TextField(
              controller: password,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 20, bottom: 20, end: 20),
            child: TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Phone',
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          SizedBox(height: 10),
          Stack(
            children: [
              InkWell(
                onTap:()async{
                  await myDb.addData(NoteModel(name.text.toString(), password.text.toString(), int.parse(phone.text.toString())));
                  getdata();
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top:12,start:60),
                child: Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 22)),
              )
            ],
          )
        ],
      ),
    );
  }
  void getdata()async{
    var detail=await myDb.CheckLogin(name.text.toString(), password.text.toString());
    if(detail.isNotEmpty){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
    }
    else if(detail.isEmpty){
      return showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text('Enter Valid Details'),
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
          title: Text('TextFields cant Empty'),
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
