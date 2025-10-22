import 'package:flutter/material.dart';

import '../../reusables/constants.dart';
import '../../reusables/formbuilder.dart';

class TrailInput extends StatelessWidget {
   TrailInput({super.key});



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  final Map<String, dynamic> formSchema = {
    "fields":[
      {
        "type": "text",
        "label": "id",
        "placeholder": "John",
        "jsonKey":"id",
        "required": false
      },
      {
        "type": "text",
        "label": "Name",
        "placeholder": "Doe",
        "jsonKey":"name",
        "required": true
      },
      {
        "type": "text",
        "label": "Reg No",
        "placeholder": "abc/123/",
        "jsonKey":"regNo",
        "required": true
      },
      {
        "type": "email",
        "label": "Email",
        "placeholder": "mail@mail.com",
        "jsonKey":"email",
        "required": false
      },
    ]
  };


  // Map

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'John Doe',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            SizedBox(height: 10,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'example@email.com',
                prefixIcon: Icon(Icons.email),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                ),
              ),
            ),

            // buildField("id",formSchema, _formData),
            Row(
              children: [

                buildField("Name",formSchema, _formData),
                buildField("Reg No",formSchema, _formData),
              ],
            ),
            ElevatedButton(
              onPressed: ()async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print(_formData);
                  var resu = await auth.saveMany(_formData, "/api/school/student/add");
                  print(resu.runtimeType);
                  print(resu);
                  if(resu[0]['success']){
                    _formData.clear();
                  }
                  // print('Form Data: $_formData');
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('Form submitted!')),
                  // );
                }
              },
              child: Text('Submit'),
            ),

          ],
        ),
      ),
    );
  }
}
