import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:multimodule/Wrapper.dart';
import 'package:multimodule/reusables/RoundedContainer.dart';
import 'package:multimodule/reusables/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final StreamController<SessionState> sessionStateStream;
  const Login({Key? key, required this.sessionStateStream}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var username, password;
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Text('Image'),
         /* Container(
              width: MediaQuery.of(context).size.width * 0.6,
              // width:4.sh,
              height: MediaQuery.of(context).size.height,
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset("assets/images/login_bg.jpg")
              )
          ),*/
          Expanded(
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width:450,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      onChanged: (val){
                        setState(() {
                          username = val;
                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Username',
                          prefixIcon: Icon(Icons.perm_identity_rounded)
                      ),
                    ),
                  ),
                  Divider(height: 40,color: Colors.white,),
                  Container(
                    width:450,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      obscureText: obscure,
                      onChanged: (val){
                        setState(() {
                          password = val;
                        });
                      },
                      onFieldSubmitted: (value) {
                        login();
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          // focusedBorder: ,
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: InkWell(
                              onTap: (){
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              child: Icon(Icons.remove_red_eye)
                          )
                      ),
                    ),
                  ),
                  Container(
                    width: 450,
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: (){},
                        child: Text('Forgot Password ?')
                    ),
                  ),
                  Divider(height: 40,color: Colors.white,),

                  GestureDetector(
                    onTap: ()async{


                      final Map<String, dynamic> data = {
                        "userName":"${username}",
                        "password":"${password}",
                      };

                      print(data);

                      var resu = await auth.getvalues("api/setup/auth/list?userName=${username}&password=${password}");
                      print('here is the results in logging in${resu}');
                      if(resu.isNotEmpty){
                        print(resu);
                        var resu2 = await auth.getvalues("api/setup/user/list?user_id=${resu[0]['user_id']}");
                        if(resu2.isNotEmpty){
                          print(resu2.runtimeType);
                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          dynamic alldata = resu2;
                          preferences.setString('userData', jsonEncode(alldata));

                          Navigator.push(context, MaterialPageRoute(builder: (_) =>  Wrapper(sessionStateStream: widget.sessionStateStream,)));

                          // SharedPreferences sharedPrf = SharedPreferences.getInstance();
                        }
                        print(resu2);
                      }else{
                        final snackBar = SnackBar(
                          content: Text('Wrong Username or Password'),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                        // SnackBar.
                      }

                      // var resu = await auth.
                    },
                    child: SContainer(
                      color: primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Login'),
                      ),
                    ),
                  ),



                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     btns(label: 'Login',
                  //       onclick: () => login(),),
                  //   ],
                  // )
                  // TextButton(
                  //   style: ButtonStyle(
                  //     backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueAccent),
                  //   ),
                  //     onPressed: (){
                  //       Navigator.push(context, MaterialPageRoute(builder: (_) =>  AllHomes(sessionStateStream: widget.sessionStateStream,)));
                  //       // Navigator.of(context).
                  //     }, child: Padding(
                  //       padding: const EdgeInsets.all(15.0),
                  //       child: Text('Login',style: header2,),
                  //     ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  login()async {
    // var resu = await auth.login(username, password);
    // print(resu);
    /*if (resu is User) {
      // const SnackBar(
      //   backgroundColor: Colors.green,
      //   content: Text('Login Success'),
      // );
      // var showToast = Fluttertoast.showToast(
      //     msg: 'Login Success',
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 3,
      //     backgroundColor: Colors.green,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
      // showReturnMessage(context, Colors.green,'Login Success');
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Messaging(sessionStateStream: widget.sessionStateStream)));
      Navigator.push(context, MaterialPageRoute(
          builder: (_) =>
              Wrapper(sessionStateStream: widget
                  .sessionStateStream,)));
      // Navigator.push(context, MaterialPageRoute(builder: (_) =>  Modules(session: widget.sessionStateStream,)));

    } else {
      SnackBar(
        backgroundColor: Colors.red,
        // content: Text('${resu["data"]}'),
        content: Text(''),
      );

      // Navigator.push(context, MaterialPageRoute(builder: (_) =>  Modules()));
    }*/
  }

}