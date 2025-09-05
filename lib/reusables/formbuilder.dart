import 'package:dropdown_button2/dropdown_button2.dart';
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


Widget buildField(String fieldKey, Map<String, dynamic> formSchema,  Map<String, dynamic> formData, [List<dynamic>? dropdata] ){

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
  final String jsonKey = field['name'] ?? label;
  // final String fieldKey = field['key'];

  switch(type){
    // case "text":
    case "text":
    case "string":
    case "email":
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 150,
                child: Text("${fieldKey}\t",style: TextStyle(fontWeight: FontWeight.w600,letterSpacing: 0.5,fontSize: 12),)),
            SizedBox(height: 5,),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 100,  // Minimum width the child should take
                maxWidth: 600,
                maxHeight: 40// Maximum width allowed (or use double.infinity if allowed by parent)
              ),
              // width: 250,
              // height: 40,// Width for 2-column layout
              child: TextFormField(
                initialValue: formData[jsonKey]?.toString() ?? '',
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

    case "dropdown":
    case "select":
      // final List<dynamic> options = field['options'] ?? [];
      final List<dynamic> options = dropdata ?? [];

  final dropdownValue = (formData[placeholder] ?? formData[jsonKey])?.toString();
  final validValues = dropdata!.map((e) => e['value']).toSet();
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$label", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
            SizedBox(height: 5),


            /*DropdownButtonFormField2<String>(
              isExpanded: true,
              // value: (formData[placeholder] ?? formData[jsonKey])?.toString() ?? '',
              value: "",

              // Match value from formData
              // value: formData[placeholder] ?? formData[jsonKey] as String?, // assuming you're storing the "value" string

              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              // Build dropdown items from uniform map structure
              items: dropdata!.map<DropdownMenuItem<String>>((option) {
                return DropdownMenuItem<String>(
                  value: option['value'], // actual value stored
                  child: Text(option['label']), // label shown in dropdown
                );
              }).toList(),

              onChanged: (String? value) {
                formData[jsonKey] = value;
              },

              validator: required
                  ? (value) {
                if (value == null || value.isEmpty) {
                  return '$label is required';
                }
                return null;
              }
                  : null,
            )*/

            DropdownButtonFormField2<String>(
              isExpanded: true,
              value: (dropdownValue != null && validValues.contains(dropdownValue))
                  ? dropdownValue
                  : null,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: dropdata!.map<DropdownMenuItem<String>>((option) {
                return DropdownMenuItem<String>(
                  value: option['value'],
                  child: Text(option['label']),
                );
              }).toList(),
              onChanged: (String? value) {
                formData[jsonKey] = value;
              },
              validator: required
                  ? (value) {
                if (value == null || value.isEmpty) {
                  return '$label is required';
                }
                return null;
              }
                  : null,
            )


            /*DropdownButtonFormField2<String>(
              isExpanded: true,
              value: formData[fieldKey] ?? formData[jsonKey] as String?,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                // maxHeight: defaultheight*0.4,
              ),
              items: options.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option.toString()),
                );
              }).toList(),
              onChanged: (String? value) {
                formData[jsonKey] = value;
              },
              validator: required
                  ? (value) {
                if (value == null || value.isEmpty) {
                  return '$label is required';
                }
                return null;
              }
                  : null,
            )*/
          ],
        ),
      );


  /*return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$label", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
            SizedBox(height: 5),
            DropdownButtonFormField(
              value: formData[jsonKey],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
              items: options.map<DropdownMenuItem>((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option.toString()),
                );
              }).toList(),
              onChanged: (value) {
                formData[jsonKey] = value;
              },
              validator: required
                  ? (value) {
                if (value == null) return '$label is required';
                return null;
              }
                  : null,
            ),
          ],
        ),
      );*/
    default:
      return SizedBox.shrink();
  }

}