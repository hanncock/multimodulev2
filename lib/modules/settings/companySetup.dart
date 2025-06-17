import 'package:flutter/material.dart';
import 'package:multimodule/reusables/formbuilder.dart';

import '../../reusables/constants.dart';

class CompanySetup extends StatefulWidget {
  const CompanySetup({super.key});

  @override
  State<CompanySetup> createState() => _CompanySetupState();
}

class _CompanySetupState extends State<CompanySetup> {

  Map<String, dynamic> _formData = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Map<String, dynamic> formSchema={};



  getFields()async{
    var resu = await auth.getvalues("apifields/setup/company");
    print(resu);
    setState(() {
      formSchema = resu;
    });
  }


  @override
  void initState(){
    super.initState();
    getFields();
  }

  @override
  Widget build(BuildContext context) {
    return formSchema.isEmpty ? Text('loading') :SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('${formSchema}'),
              buildField("CompanyName", formSchema, _formData),
              Row(
                children: [
                  buildField("Reg No", formSchema, _formData),
                  buildField("Tax Pin", formSchema, _formData),

                ],
              ),
              // buildField("id", formSchema, _formData),
              buildField("NSSFNo", formSchema, _formData),
              Row(
                children: [
                  buildField("Postal Code", formSchema, _formData),
                  buildField("Country", formSchema, _formData),

                ],
              ),
              Row(
                children: [
                  buildField("Town", formSchema, _formData),
                  buildField("Road /Street", formSchema, _formData),
                ],
              ),
              Row(
                children: [
                  buildField("Email", formSchema, _formData),
                  buildField("Phone", formSchema, _formData),
                ],
              ),
              buildField("Position", formSchema, _formData),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        var resu = await auth.saveMany(_formData, "/api/setup/company/add");
                        print(resu);
                       /* print('Form Data: $_formData');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Form submitted!',style: TextStyle(color: Colors.red),)),
                        );*/
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),

          ],
          ),
      ),
    );
  }
}


