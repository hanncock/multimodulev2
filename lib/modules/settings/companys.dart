import 'package:flutter/material.dart';
import '../../reusables/constants.dart';

class Companies extends StatefulWidget {
  const Companies({super.key});

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {

  List companies = [];

  getCompanies()async{
    var resu = await auth.getvalues("api/setup/company/list");
    print("values found are ${resu}");
    setState(() {
      companies= resu;
    });
  }

  @override
  void initState(){
    super.initState();
    getCompanies();
    print("getting values");

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ListView.builder(
          shrinkWrap: true,
              itemCount:companies.length,
              itemBuilder: (context, index){
                return Text('${companies[index]}');
              }),
          Text('this are the values')
        ],
      ),
    );
  }
}
