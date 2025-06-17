import 'package:flutter/material.dart';
import '../../reusables/constants.dart';
import '../../reusables/tablemaker.dart';

class Companies extends StatefulWidget {
  const Companies({super.key});

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {

  List companies = [];

  getCompanies()async{
    var resu = await auth.getvalues("api/setup/company/list");
    // print("values found are ${resu}");
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
          /*ListView.builder(
          shrinkWrap: true,
              itemCount:companies.length,
              itemBuilder: (context, index){
                return Text('${companies[index]}');
              }),*/
          Text('Another menu will go here'),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.1)
            ),
            // padding: EdgeInsets.symmetric(vertical: 0,horizontal: 2),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            child: CustomTable(
              headers: [
                "company_id",
                "module_id",
                "companyName",
                "regNo",
                "taxPin",
                "postalCode",
                "country",
                "town",
                "road",
                "email",
                "phone",
                "position",
              ],
              formDataList: companies,
              fixedColumnCount: 2, ),
          )
        ],
      ),
    );
  }
}

