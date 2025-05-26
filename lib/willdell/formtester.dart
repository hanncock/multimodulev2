/*
import 'package:flutter/material.dart';

class Formtester extends StatefulWidget {
  const Formtester({super.key});

  @override
  State<Formtester> createState() => _FormtesterState();
}

class _FormtesterState extends State<Formtester> {

  // Map<String >


  */
/* @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('this is a test factory')
        ],
      ),
    );
  }*//*

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  final Map<String, dynamic> formSchema = {
    "fields": [
      {
        "type": "text",
        "label": "Name",
        "placeholder": "Your name",
        "required": true
      },
      {
        "type": "email",
        "label": "Email",
        "placeholder": "you@example.com",
        "required": true
      },
      {
        "type": "text",
        "label": "Email",
        "placeholder": "you@example.com",
        "required": false
      }
    ]
  };

  Widget _buildField(Map<String, dynamic> field) {
    final String type = field['type'];
    final String label = field['label'];
    final String placeholder = field['placeholder'] ?? '';
    final bool required = field['required'] ?? false;

    switch (type) {
      case 'text':
      case 'email':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text('${label}',style: TextStyle(fontWeight: FontWeight.bold),),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(

                */
/*decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 5,top: 2,bottom: 5),

                  fillColor: Colors.white,

                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.5, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10)

                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  labelText: label,
                  hintText: placeholder,
                ),*//*



                  decoration: InputDecoration(
                    filled: true,
                    // fillColor: Theme.of(context).colorScheme.surface,
                    fillColor: Colors.white,
                    // contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),

                    labelText: label,
                    hintText: placeholder,

                    floatingLabelBehavior: FloatingLabelBehavior.auto,

                    // Use Material 3 default rounded border
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,


                */
/*decoration: InputDecoration(
                  // labelText: label,
                  // hintText: placeholder,
                ),*//*

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
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> formFields = formSchema['fields']
        .map<Widget>((field) => _buildField(field))
        .toList();

    formFields.add(
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
    );

    return Scaffold(
      appBar: AppBar(title: Text('Dynamic Form Builder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Row(
            children: [
              Expanded(child: Column(children: formFields)),
              Expanded(child: Column(children: formFields)),
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';


class DynamicFormScreen extends StatefulWidget {
  @override
  _DynamicFormScreenState createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<DynamicFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  final Map<String, dynamic> formSchema = {
    "fields": [
      {
        "type": "text",
        "label": "First Name",
        "placeholder": "John",
        "required": true
      },
      {
        "type": "text",
        "label": "Last Name",
        "placeholder": "Doe",
        "required": true
      },
      {
        "type": "email",
        "label": "Email",
        "placeholder": "you@example.com",
        "required": true
      },
      {
        "type": "text",
        "label": "Phone",
        "placeholder": "123-456-7890",
        "required": false
      },
      {
        "type": "text",
        "label": "extra",
        "placeholder": "123-456-7890",
        "required": false
      }
    ]
  };

  Widget _buildField(Map<String, dynamic> field) {
    final String type = field['type'];
    final String label = field['label'];
    final String placeholder = field['placeholder'] ?? '';
    final bool required = field['required'] ?? false;

    switch (type) {
      case 'text':
      case 'email':
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
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> formFields = formSchema['fields']
        .map<Widget>((field) => _buildField(field))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Styled Dynamic Form')),
      /*body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: formFields,
              ),
              SizedBox(height: 24),
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
            ],
          ),
        ),
      ),*/
    );
  }
}
