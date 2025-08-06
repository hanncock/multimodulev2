import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthService{

  // String url ="http://0.0.0.0:3000";
  String url ="http://0.0.0.0:8080";
  // String url ="http://192.168.1.129:8080";
  // String url ="https://106e-41-209-57-162.ngrok-free.app";

  Map<String, String> headers = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };

  saveMany(val,endpoint)async{

    var all = '${url}${endpoint}';
    var send = jsonEncode(val);
    var response = await http.post(Uri.parse(all), body: send, headers: headers);
    var responseData = jsonDecode(response.body);
    return responseData;
  }

  getvalues(endpoint)async{
    // print("getting values");
    var fetchedData = Uri.encodeFull("$url/$endpoint");
    // print(fetchedData);
    try{
      var response =  await get(Uri.parse(fetchedData));
      var jsondata = jsonDecode(response.body);
      // print("here are the fetched${jsondata}");

      return jsondata['data'];
      // return jsondata;
    }catch(e){
      return e.toString();
    }
  }

}