import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*class Formbuilder extends StatefulWidget {
  final Map<String, dynamic> formfieldsSchema;
  final Map<String, dynamic> formData;

  const Formbuilder({super.key,
    required this.formfieldsSchema,
    required this.formData
  });

  @override
  State<Formbuilder> createState() => _FormbuilderState();
}

class _FormbuilderState extends State<Formbuilder> {

  Widget _builField(String fieldKey) {
    final field = widget.formfieldsSchema["fields"].firstWhere((field) =>
    field['label'] == fieldKey, orElse: () => <String, Object>{}
    );

    if(field == null){
      return SizedBox.shrink();
    }

    final String type = field['type'];
    final String label = field['label'];
    final String placeholder = field['placeholder'] ?? '';
    final bool required = field['required'] ?? false;
    // final String fieldKey = field['key'];

    switch(type){
      case "text":
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
              onSaved: (value) => widget.formData[label] = value,
            ),
          ),
        );
      default:
        return SizedBox.shrink();
    }


  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}*/


Widget buildField(String fieldKey, Map<String, dynamic> formSchema,  Map<String, dynamic> formData){

  final String key = formSchema.keys.first;

  final field = formSchema[key].firstWhere(
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
  // final String jsonKey = field['jsonKey'];
  // final String fieldKey = field['key'];

  switch(type){
    // case "text":
    case ("text" || "string"):
    // case "string":
    case "email":
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 120,
                child: Text("${fieldKey}\t:",style: TextStyle(fontWeight: FontWeight.w600,letterSpacing: 0.5),)),
            SizedBox(height: 5,),
            SizedBox(
              width: 350,
              height: 40,// Width for 2-column layout
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: label,
                  hintText: placeholder,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 4)
                ),
                // style: TextStyle(fontSize: 13),
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
                onSaved: (value) => formData[placeholder] = value,
              ),
            ),
          ],
        ),
      );
    default:
      return SizedBox.shrink();
  }

}