/setup => create tables
/apifields/{module}/{class} => get the fields
/showclasses => get the classes/tables
/api/{module}/{class} =>  get the data



case "dropdown":
case "select":
final List<dynamic> options = field['options'] ?? [];

return Padding(
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
);



case "dropdown":
final List<dynamic> options = field['options'] ?? [];

return Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
SizedBox(height: 5),
DropdownButtonFormField(
value: formData[jsonKey],
decoration: InputDecoration(
border: OutlineInputBorder(),
contentPadding: EdgeInsets.symmetric(horizontal: 8),
),
items: options.map<DropdownMenuItem>((option) {
if (option is Map) {
return DropdownMenuItem(
value: option['value'],
child: Text(option['label'].toString()),
);
}
return DropdownMenuItem(
value: option,
child: Text(option.toString()),
);
}).toList(),
onChanged: (value) {
formData[jsonKey] = value;
},
validator: required
? (value) => value == null ? '$label is required' : null
: null,
),
],
),
);
