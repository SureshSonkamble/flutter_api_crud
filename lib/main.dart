import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
//import package file manually

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        theme: ThemeData(
          primarySwatch:Colors.red, //primary color for theme
        ),
        home: WriteSQLdata() //set the class here
    );
  }
}

class WriteSQLdata extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WriteSQLdataState();
  }
}

class WriteSQLdataState extends State<WriteSQLdata>{

  TextEditingController id = TextEditingController();
  TextEditingController namectl = TextEditingController();
  TextEditingController addressctl = TextEditingController();
  TextEditingController classctl = TextEditingController();
 // TextEditingController rollnoctl = TextEditingController();
  //text controller for TextField

  late bool error, sending, success;
  late String msg;

  String addurl = "https://vsproi.com/WS_API/insert_test.php?";
  String delurl = "https://vsproi.com/WS_API/delete_test.php?";
  String updateurl = "https://vsproi.com/WS_API/update_test.php?";
  // do not use http://localhost/ for your local
  // machine, Android emulation do not recognize localhost
  // insted use your local ip address or your live URL
  // hit "ipconfig" on Windows or  "ip a" on Linux to get IP Address

  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    msg = "";
    super.initState();
  }

  Future<void> sendData() async {

    var res = await http.post(Uri.parse(addurl), body: {
      "name": namectl.text,
      "addr": addressctl.text,
      "email": classctl.text,
     // "rollno": rollnoctl.text,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
     // print(data);
      print(data["posts"]["status"]);
      if(data["posts"]["status"]=="200"){

        namectl.text = "";
        addressctl.text = "";
        classctl.text = "";
        // rollnoctl.text = "";
        //after write success, make fields empty

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });

      }else{
        setState(() { //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          // msg = data["message"]; //error message from server
        });

      }

    }else{
      //there is error
      setState(() {
        error = true;
        msg = "Error during sendign data.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }
  Future<void> updateData() async {

    var res = await http.post(Uri.parse(updateurl), body: {
      "id": id.text,
      "name": namectl.text,
      "addr": addressctl.text,
      "email": classctl.text,
      // "rollno": rollnoctl.text,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      // print(data);
      print(data["posts"]["status"]);
      if(data["posts"]["status"]=="200"){

        id.text = "";
        namectl.text = "";
        addressctl.text = "";
        classctl.text = "";
        // rollnoctl.text = "";
        //after write success, make fields empty

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });

      }else{
        setState(() { //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          // msg = data["message"]; //error message from server
        });

      }

    }else{
      //there is error
      setState(() {
        error = true;
        msg = "Error during sendign data.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }
  Future<void> deleteData() async {

    var res = await http.post(Uri.parse(delurl), body: {
      "id": id.text,
      //"addr": addressctl.text,
     // "email": classctl.text,
      // "rollno": rollnoctl.text,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array
      // print(data);
      print(data["posts"]["status"]);
      if(data["posts"]["status"]=="200"){

        namectl.text = "";
        addressctl.text = "";
        classctl.text = "";
        // rollnoctl.text = "";
        //after write success, make fields empty

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });

      }else{
        setState(() { //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          // msg = data["message"]; //error message from server
        });

      }

    }else{
      //there is error
      setState(() {
        error = true;
        msg = "Error during sendign data.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Text("Write Data PHP & MySQL"),
          backgroundColor:Colors.redAccent
      ), //appbar

      body: SingleChildScrollView( //enable scrolling, when keyboard appears,
        // hight becomes small, so prevent overflow
          child:Container(
              padding: EdgeInsets.all(20),
              child: Column(children: <Widget>[

                Container(
                  child:Text(error?msg:"Enter Student Information"),
                  //if there is error then sho msg, other wise show text message
                ),

                Container(
                  child:Text(success?"Write Success":"send data"),
                  //is there is success then show "Write Success" else show "send data"
                ),
                Container(
                    child: TextField(
                      controller: id,
                      decoration: InputDecoration(
                        labelText:"Student ID:",
                        hintText:"Enter student ID",
                      ),
                    )
                ), //text input for name

                Container(
                    child: TextField(
                      controller: namectl,
                      decoration: InputDecoration(
                        labelText:"Full Name:",
                        hintText:"Enter student full name",
                      ),
                    )
                ), //text input for name

                Container(
                    child: TextField(
                      controller: addressctl,
                      decoration: InputDecoration(
                        labelText:"Address:",
                        hintText:"Enter student address",
                      ),
                    )
                ), //text input for address

                Container(
                    child: TextField(
                      controller: classctl,
                      decoration: InputDecoration(
                        labelText:"Email:",
                        hintText:"Enter student Email",
                      ),
                    )
                ), //text input for class

                Container(
                    margin: EdgeInsets.only(top:20),
                    child:SizedBox(
                        width: double.infinity,
                        child:RaisedButton(
                          onPressed:(){ //if button is pressed, setstate sending = true, so that we can show "sending..."
                            setState(() {
                              sending = true;
                            });
                            sendData();
                          },
                          child: Text(
                            sending?"Sending...":"SEND DATA",
                            //if sending == true then show "Sending" else show "SEND DATA";
                          ),
                          color: Colors.redAccent,
                          colorBrightness: Brightness.dark,
                          //background of button is darker color, so set brightness to dark
                        )
                    )
                )
                ,
                Container(
                    margin: EdgeInsets.only(top:20),
                    child:SizedBox(
                        width: double.infinity,
                        child:RaisedButton(
                          onPressed:(){ //if button is pressed, setstate sending = true, so that we can show "sending..."
                            setState(() {
                              sending = true;
                            });
                           deleteData();
                          },
                          child: Text(
                            sending?"Deleting ...":"DELETE DATA",
                            //if sending == true then show "Sending" else show "SEND DATA";
                          ),
                          color: Colors.redAccent,
                          colorBrightness: Brightness.dark,
                          //background of button is darker color, so set brightness to dark
                        )
                    )
                ),
                Container(
                    margin: EdgeInsets.only(top:20),
                    child:SizedBox(
                        width: double.infinity,
                        child:RaisedButton(
                          onPressed:(){ //if button is pressed, setstate sending = true, so that we can show "sending..."
                            setState(() {
                              sending = true;
                            });
                              updateData();
                          },
                          child: Text(
                            sending?"Deleting ...":"UPDATE DATA",
                            //if sending == true then show "Sending" else show "SEND DATA";
                          ),
                          color: Colors.redAccent,
                          colorBrightness: Brightness.dark,
                          //background of button is darker color, so set brightness to dark
                        )
                    )
                )
              ],)
          )
      ),
    );
  }
}