import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:multimodule/services/AuthService.dart';
import 'package:intl/intl.dart';


int desktopScreenSize = 1366;
int tableScreenSize = 768;
int mobileScreenSize = 400;

AuthService auth = AuthService();



const dateFormat1 = 'dd-MMM-yyyy | hh:mm a';
const dateFormat2 = 'd MMM, yyyy';
const dateFormat3 = 'dd-MMM-yyyy';
const dateFormat4 = 'yyyy-MM-dd';
const dateFormat5 = 'MMM, yyyy';
const dateFormat6 = 'MM-yyyy';
const year = 'yyyy';
const month = 'MMM';
const day = 'dd';
const timeofDay = 'HH:mm:ss';

const emptyImage = 'assets/lotties/empty-box.json';

// const Color primaryColor = Colors.red;
const Color primaryColor = Color(0xFF176EC4);

const String isRequired = 'Required*';

const String permissions = 'You do not have enough permissions to do this!';


void hideKeyboard(context) => FocusScope.of(context).requestFocus(FocusNode());

String defaultServer = 'https://cloud.ezenfinancials.com';

var companyDetails;

final currency = NumberFormat.simpleCurrency(decimalDigits: 0, name: '');


// loadServerUrl() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   var defaultServer = prefs.getString('url') ?? 'https://cloud.ezenfinancials.com';
//   return defaultServer;
// }

// extension StringCasingExtension on String {
//   String capitalize() =>
//       length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
//   String toTitleCase() => replaceAll(RegExp(' +'), ' ')
//       .split(' ')
//       .map((str) => str.capitalize())
//       .join(' ');
// }

// loaddefaultCompany()async{
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   var fndCompany = prefs.getString('company') ?? UserData['allowedCompanies'][0];
//   // var fndCompany;
//   // if(prefs.getString('company')!.isEmpty) {
//   //   fndCompany =  UserData['allowedCompanies'][0];
//   // }else{
//   //   fndCompany = prefs.getString('company');
//   // }
//   return jsonDecode(fndCompany);
// }

// savedefaultCompany(newcompanyDetails)async{
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   companyDetails = newcompanyDetails;
//   prefs.setString('company',jsonEncode(newcompanyDetails));
//   loaddefaultCompany();
// }
//
// generateRandomColor() {
//   return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);
// }
//
// clearLogins()async{
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.remove('company');
//   prefs.remove('data');
//   // companyDetails = newcompanyDetails;
//   // prefs.setString('company',jsonEncode(newcompanyDetails));
// }
//
// Future switchProperty(BuildContext context) {
//   final searchController = TextEditingController();
//
//   return showBarModalBottomSheet(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(10.r,),
//         topRight: Radius.circular(10.r,),
//       ),
//     ),
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//           builder: (context,setState) {
//             return Container(
//               height: .7.sh,
//               child: Column(
//                 children: [
//
//                   Padding(
//                     padding:  EdgeInsets.all(8.r),
//                     child: Text('Switch Property',
//                       style:Theme.of(context)
//                           .textTheme
//                           .titleMedium!
//                           .copyWith(
//                         fontWeight: FontWeight.w600,
//                       ),),
//                   ),
//
//                   Padding(
//                     padding:EdgeInsets.all(8.r),
//                     child: InputTextWidget(
//                       label: 'Search Property',
//                       controller: searchController,
//                       changed: (String value) {
//                         print(value);
//                         filterSearchProps(properties,"name" ,value,);
//                         setState((){});
//                       },
//
//                     ),
//                   ),
//
//                   Expanded(
//                     child: Container(
//                       child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: srchProperties.isEmpty ? properties.length : srchProperties.length,
//                           padding: EdgeInsets.symmetric(horizontal: 8.w),
//                           itemBuilder: (context,index){
//                             var selProp = srchProperties.isEmpty ? properties[index] : srchProperties[index];
//                             return InkWell(
//                               onTap: (){
//                                 print('switching');
//                                 currProp = selProp;
//                                 setState((){});
//                                 Navigator.of(context).pop();
//                               },
//                               child: Card(
//                                 child: Padding(
//                                   padding: EdgeInsets.all(8.r),
//                                   child: Row(
//                                     children: [
//                                       CircleAvatar(
//                                         backgroundColor: generateRandomColor(),
//                                         radius: 18.r,
//                                         child: Text("${selProp['name'][0]}",
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: 8.w),
//                                       Expanded(
//                                         child: Text(
//                                           maxLines: 1,
//                                           "${capitalizeEachWord(selProp['name'])}",
//                                           overflow: TextOverflow.ellipsis,
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium!
//                                               .copyWith(letterSpacing: 1),
//                                         ),
//                                       ),
//                                       // const Spacer(),
//                                       const Icon(Icons.navigate_next)
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                             /*return Row(
//                         children: [
//                           Text('${company['companyName']}',
//                             softWrap: true,
//                           )
//                         ],
//                       );*/
//                           }),
//                       // child: const ListAccessCompanies(),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//       );
//     },
//   );
// }

//
// Widget getTitleItemWidget(String label, double width) {
//   return Container(
//     width: width,
//     height: 30.h,
//     padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//     alignment: Alignment.centerLeft,
//     child: Text(
//       label,
//       style: const TextStyle(fontWeight: FontWeight.bold),
//     ),
//   );
// }
//
//
// String getNameInitials(String text) {
//   final initials = text.contains(' ')
//       ? text.split(' ')[0][0].toUpperCase() +
//       text.split(' ')[1][0].toUpperCase()
//       : text.substring(0, 1).toUpperCase();
//   return initials;
// }
//
// String formatDate(
//     String? dateTime, {
//       String format = dateFormat1,
//       bool isFromMicrosecondsSinceEpoch = false,
//     }) {
//   if (isFromMicrosecondsSinceEpoch) {
//     return DateFormat(format).format(
//       DateTime.fromMicrosecondsSinceEpoch(
//         dateTime.validate().toInt() * 1000,
//       ),
//     );
//   } else {
//     return DateFormat(format).format(DateTime.parse(dateTime.validate()));
//   }
// }