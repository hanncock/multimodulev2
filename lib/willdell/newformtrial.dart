import 'package:flutter/material.dart';
import '../reusables/constants.dart';

class Newformtrial extends StatefulWidget {
  const Newformtrial({super.key});

  @override
  State<Newformtrial> createState() => _NewformtrialState();
}

class _NewformtrialState extends State<Newformtrial> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _formData = {};

  late Map<String, dynamic> formSchema={};

  getFiels()async{
    var resu = await auth.getvalues("apifields/school/student");
    setState(() {
      formSchema = resu;
    });
  }


  @override
  void initState(){
    super.initState();
    getFiels();
  }

  Widget _buildField(String fieldKey){

    final field = formSchema["fields"].firstWhere(
          (field) => field['label'].toLowerCase() == fieldKey.toLowerCase(),
      orElse: () => <String, Object>{}
    );


    // If field is not found, return an empty container
    if (field == null || field.isEmpty) {
      return SizedBox.shrink();
    }

    final String type = field['type'];
    final String label = field['label'];
    final String placeholder = field['placeholder'] ?? '';
    final bool required = field['required'] ?? false;
    // final String fieldKey = field['key'];

    switch(type){
      case ("text" || "string"):
      case "email":
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 300, // Width for 2-column layout
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              hintText: placeholder,
              border: OutlineInputBorder(),
            ),
            validator: required
                ? (value) {
              if (value == null || value.isEmpty) {
                return '$label is required';
              }
              if (type == 'email' && !value.contains('@')) {
                return 'Enter a valid email';
              }
              return null;
            }
                : null,
            onSaved: (value) => _formData[label] = value,
          ),
        ),
      );
      default:
        return SizedBox();
    }

  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: formSchema .isEmpty ? Text('Loading') :Form(
        key: _formKey,
        child: Column(
         children: [
           // _buildField("First Name"),

           Row(
             children: [
               _buildField("First Name"),
               // _buildField("First Name"),
             ],
           ),

           ElevatedButton(
             onPressed: () {
               if (_formKey.currentState!.validate()) {
                 _formKey.currentState!.save();
                 print('Form Data: $_formData');
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text('Form submitted!')),
                 );
               }
             },
             child: Text('Submit'),
           ),

           // InputForm()

         ],

        ),
      ),
    );
  }
}



