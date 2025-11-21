// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
//
// Widget buildField(
//     String fieldKey,
//     Map<String, dynamic> formSchema,
//     Map<String, dynamic> formData,
//     // [List<dynamic>? dropdata,
//     //   dynamic? labelKey,
//     //   String? valueKey,
//     // ]){
//     [List<dynamic>? dropdata,
//       dynamic? labelKey,
//       String? valueKey,
//       Function? onUpdate]){
//
//   final String key = formSchema.keys.first;
//
//   final field = formSchema[key].firstWhere(
//           (field) => field['label'].toLowerCase() == fieldKey.toLowerCase(),
//       orElse: () => <String, Object>{}
//   );
//
//   // If field is not found, return an empty container
//   if (field == null || field.isEmpty) {
//     return SizedBox.shrink();
//   }
//
//   final String type = field['type'];
//   final String label = field['label'];
//   final String placeholder = field['placeholder'] ?? '';
//   final bool required = field['required'] ?? false;
//   final String jsonKey = field['name'] ?? label;
//   // final String fieldKey = field['key'];
//
//   switch(type){
//     // case "text":
//     case "text":
//     case "string":
//     case "email":
//     case "int":
//
//     final isNumeric = type.toLowerCase() == 'int' || type.toLowerCase() == 'number';
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//                 width: 150,
//                 child: Text("${fieldKey}\t",style: TextStyle(fontWeight: FontWeight.w600,letterSpacing: 0.5,fontSize: 12),)),
//             SizedBox(height: 5,),
//             TextFormField(
//               initialValue: formData[jsonKey]?.toString() ?? '',
//               keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
//               inputFormatters: isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
//               decoration: InputDecoration(
//                 prefixIcon: type == 'search' ? const Icon(Icons.search, size: 20) : null, // optional icon
//                 labelText: label,
//                 hintText: placeholder,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: BorderSide(color: Colors.deepPurple.shade400, width: 1.5),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: const BorderSide(color: Colors.grey, width: 1),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//               ),
//               style: const TextStyle(fontSize: 14),
//               validator: required
//                   ? (value) {
//                 if (value == null || value.isEmpty) {
//                   return '$label is required';
//                 }
//                 if (type == 'email' && !value.contains('@')) {
//                   return 'Enter a valid email';
//                 }
//                 if (isNumeric && int.tryParse(value) == null) {
//                   return '$label must be a number';
//                 }
//                 return null;
//               }
//                   : null,
//               onSaved: (value) => formData[jsonKey] = value, // fixed: use jsonKey, not placeholder
//             )
//
//
//           ],
//         ),
//       );
//
//     /*case "date":
//     case "datetime":
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("$label", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
//             SizedBox(height: 5),
//             InkWell(
//               onTap: () async {
//                 final DateTime? pickedDate = await showDatePicker(
//                   context: Get.context!,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2000),
//                   lastDate: DateTime(2100),
//                 );
//
//                 if (pickedDate != null) {
//                   setStateIfPossible(() {
//                     formData[jsonKey] = pickedDate.toIso8601String().split('T').first;
//                   });
//                 }
//               },
//               child: IgnorePointer(
//                 child: TextFormField(
//                   controller: TextEditingController(
//                     text: formData[jsonKey]?.toString() ?? '',
//                   ),
//                   decoration: InputDecoration(
//                     labelText: label,
//                     hintText: "Select $label",
//                     suffixIcon: Icon(Icons.calendar_today, color: Colors.deepPurple),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
//                   ),
//                   validator: required
//                       ? (value) => (value == null || value.isEmpty) ? '$label is required' : null
//                       : null,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );*/
//     case "date":
//     case "datetime":
//       bool isExpanded = formData["_show_${jsonKey}"] ?? false;
//       DateTime? selectedDate = formData[jsonKey] != null
//           ? DateTime.tryParse(formData[jsonKey])
//           : null;
//
//       return StatefulBuilder(
//         builder: (context, setInnerState) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("$label", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
//                 const SizedBox(height: 5),
//                 InkWell(
//                   onTap: () {
//                     setInnerState(() {
//                       isExpanded = !isExpanded;
//                       formData["_show_${jsonKey}"] = isExpanded;
//                     });
//                   },
//                   child: InputDecorator(
//                     decoration: InputDecoration(
//                       hintText: placeholder.isNotEmpty ? placeholder : "Select date",
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                       suffixIcon: Icon(
//                         isExpanded ? Icons.arrow_drop_up : Icons.calendar_today,
//                         size: 20,
//                       ),
//                     ),
//                     child: Text(
//                       selectedDate != null
//                           ? "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
//                           : "Select a date",
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ),
//                 if (isExpanded)
//                   Container(
//                     margin: const EdgeInsets.only(top: 8),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade400),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: CalendarDatePicker(
//                       initialDate: selectedDate ?? DateTime.now(),
//                       firstDate: DateTime(2020),
//                       lastDate: DateTime(2035),
//                       onDateChanged: (pickedDate) {
//                         setInnerState(() {
//                           selectedDate = pickedDate;
//                           isExpanded = false;
//                           formData[jsonKey] =
//                           "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//                           formData["_show_${jsonKey}"] = false;
//                         });
//                       },
//                     ),
//                   ),
//               ],
//             ),
//           );
//         },
//       );
//
//
//     case "dropdown":
//     case "select":
//       // final List<dynamic> options = field['options'] ?? [];
//       final List<dynamic> options = dropdata ?? [];
//     final String? dropdownValue = formData[jsonKey]?.toString();
//
//   // final dropdownValue = (formData[placeholder] ?? formData[jsonKey])?.toString();
//   final validValues = dropdata!.map((e) => e['value']).toSet();
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("$label", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
//             SizedBox(height: 5),
//
//             DropdownButtonFormField2<String>(
//               isExpanded: true,
//               // value: (dropdownValue != null && validValues.contains(dropdownValue))
//               //     ? dropdownValue
//               //     : null,
//               value: dropdownValue,
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 8),
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//               dropdownStyleData: DropdownStyleData(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               /*items: dropdata!.map<DropdownMenuItem<String>>((option) {
//                 return DropdownMenuItem<String>(
//                   value: option['value'],
//                   child: Text(option['label']),
//                 );
//               }).toList(),*/
//
//               items: dropdata?.map<DropdownMenuItem<String>>((item) {
//                 String display;
//
//                 if (labelKey is List<String>) {
//                   // Concatenate multiple fields for display
//                   display = labelKey.map((k) => item[k]?.toString() ?? '').join(' - ');
//                 } else {
//                   display = item[labelKey]?.toString() ?? '';
//                 }
//
//                 final value = item[valueKey]?.toString() ?? '';
//
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(display),
//                 );
//               }).toList(),
//               onChanged: (String? value) {
//                 formData[jsonKey] = value;
//
//                 if (onUpdate != null) {
//                   onUpdate(value);
//                 }
//
//               },
//               validator: required
//                   ? (value) {
//                 if (value == null || value.isEmpty) {
//                   return '$label is required';
//                 }
//                 return null;
//               }
//                   : null,
//             )
//
//
//
//           ],
//         ),
//       );
//
//
//
//     default:
//       return SizedBox.shrink();
//   }
//
// }
//
// void setStateIfPossible(VoidCallback fn) {
//   if (Get.isRegistered<State>()) {
//     (Get.find<State>() as dynamic).setState(fn);
//   } else {
//     fn();
//   }
// }
//
//


import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Widget buildField(
    String fieldKey,
    Map<String, dynamic> formSchema,
    Map<String, dynamic> formData, [
      List<dynamic>? dropdata,
      dynamic? labelKey,
      String? valueKey,
      Function? onUpdate,
      TextEditingController? controller, // ← NEW
    ]) {
  final String key = formSchema.keys.first;

  final field = formSchema[key].firstWhere(
        (field) => field['label'].toLowerCase() == fieldKey.toLowerCase(),
    orElse: () => <String, Object>{},
  );

  if (field.isEmpty) return const SizedBox.shrink();

  final String type = field['type'];
  final String label = field['label'];
  final String placeholder = field['placeholder'] ?? '';
  final bool required = field['required'] ?? false;
  final String jsonKey = field['name'] ?? label;
  final bool isNumeric = type.toLowerCase() == 'int' || type.toLowerCase() == 'number';

  // --------------------------------------------------------------------------
  // TEXT FIELDS
  // --------------------------------------------------------------------------
  if (['text', 'string', 'email', 'int'].contains(type.toLowerCase())) {
    final _controller = controller ??
        TextEditingController(text: formData[jsonKey]?.toString() ?? '');

    // Keep formData and controller in sync
    _controller.addListener(() {
      formData[jsonKey] = _controller.text;
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: _controller,
            keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
            inputFormatters:
            isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
            decoration: InputDecoration(
              labelText: placeholder.isNotEmpty ? placeholder : label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                BorderSide(color: Colors.deepPurple.shade400, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
            ),
            style: const TextStyle(fontSize: 14),
            validator: required
                ? (value) {
              if (value == null || value.isEmpty) {
                return '$label is required';
              }
              if (type == 'email' && !value.contains('@')) {
                return 'Enter a valid email';
              }
              if (isNumeric && int.tryParse(value) == null) {
                return '$label must be a number';
              }
              return null;
            }
                : null,
            onSaved: (value) => formData[jsonKey] = value,
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // DATE / DATETIME FIELDS
  // --------------------------------------------------------------------------
  if (type == "date" || type == "datetime") {
    bool isExpanded = formData["_show_${jsonKey}"] ?? false;
    DateTime? selectedDate = formData[jsonKey] != null
        ? DateTime.tryParse(formData[jsonKey])
        : null;

    return StatefulBuilder(
      builder: (context, setInnerState) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$label",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 12)),
              const SizedBox(height: 5),
              InkWell(
                onTap: () {
                  setInnerState(() {
                    isExpanded = !isExpanded;
                    // formData["_show_${jsonKey}"] = isExpanded;
                  });
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    hintText: placeholder.isNotEmpty
                        ? placeholder
                        : "Select date",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: Icon(
                      isExpanded
                          ? Icons.arrow_drop_up
                          : Icons.calendar_today,
                      size: 20,
                    ),
                  ),
                  child: Text(
                    selectedDate != null
                        ? "${selectedDate?.year}-${selectedDate?.month.toString().padLeft(2, '0')}-${selectedDate?.day.toString().padLeft(2, '0')}"
                        : "Select a date",
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              if (isExpanded)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CalendarDatePicker(
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2035),
                    onDateChanged: (pickedDate) {
                      setInnerState(() {
                        selectedDate = pickedDate;
                        isExpanded = false;
                        formData[jsonKey] =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                        // formData["_show_${jsonKey}"] = false;
                      });
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // --------------------------------------------------------------------------
  // DROPDOWN / SELECT FIELDS
  // --------------------------------------------------------------------------
  if (type == "dropdown" || type == "select") {
    final List<dynamic> options = dropdata ?? [];
    final String? dropdownValue = formData[jsonKey]?.toString();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          const SizedBox(height: 5),
          DropdownButtonFormField2<String>(
            isExpanded: true,
            value: dropdownValue,
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
            items: options.map<DropdownMenuItem<String>>((item) {
              String display;
              if (labelKey is List<String>) {
                display =
                    labelKey.map((k) => item[k]?.toString() ?? '').join(' - ');
              } else {
                display = item[labelKey]?.toString() ?? '';
              }
              final value = item[valueKey]?.toString() ?? '';
              return DropdownMenuItem<String>(
                value: value,
                child: Text(display),
              );
            }).toList(),
            onChanged: (String? value) {
              formData[jsonKey] = value;
              if (onUpdate != null) onUpdate(value);
            },
            validator: required
                ? (value) {
              if (value == null || value.isEmpty) {
                return '$label is required';
              }
              return null;
            }
                : null,
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // DEFAULT FALLBACK
  // --------------------------------------------------------------------------
  return const SizedBox.shrink();
}

void setStateIfPossible(VoidCallback fn) {
  if (Get.isRegistered<State>()) {
    (Get.find<State>() as dynamic).setState(fn);
  } else {
    fn();
  }
}
