import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication.dart';
import 'allmodules.dart';



class Wrapper extends StatefulWidget {

  final StreamController<SessionState> sessionStateStream;
  const Wrapper({Key? key,required this.sessionStateStream}) : super(key: key);
  @override
  State<Wrapper> createState() => _WrapperState();
}

var session;
var Userdata ;

var companyId;
var companyName;


class _WrapperState extends State<Wrapper> {

  checkValues()async{
    SharedPreferences user = await SharedPreferences.getInstance();
    var data = user.getString('userData');
    // setState(() {
    //   session = widget.sessionStateStream;
    // });

    if(data == null){
      Navigator.push(context, MaterialPageRoute(builder: (_) =>  Login(sessionStateStream: widget.sessionStateStream,)));

    }else{

      setState(() {
        Userdata = jsonDecode(data);
        companyId = Userdata[0]['companys'][0]['company_id'];
        companyName = Userdata[0]['companys'][0]['companyName'];
      });

      // flutter how to make a tab not refresh its state
      // widget.sessionStateStream.add(SessionState.stopListening);
      // Navigator.push(context, MaterialPageRoute(builder: (_) =>  AllHomes(sessionStateStream: widget.sessionStateStream,)));
      Navigator.push(context, MaterialPageRoute(builder: (_) =>  Allmodules()));
      // Navigator.push(context, MaterialPageRoute(builder: (_) =>  widtest()));
      // Navigator.push(context, MaterialPageRoute(builder: (_) =>  Login(sessionStateStream: widget.sessionStateStream,)));
      // widget.sessionStateStream.add(SessionState.startListening);

    }

  }

  @override
  void initState() {
    checkValues();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text(' this is the wrapper'));
  }
}