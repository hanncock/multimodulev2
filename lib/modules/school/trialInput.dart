import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TrailInput extends StatelessWidget {
  const TrailInput({super.key});


  // Map

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Input name"),

      FormBuilder(
        // key: _formKey,
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'email',
              decoration: InputDecoration(labelText: 'Email'),
              // validator: FormBuilderValidators.email(),
            ),
            FormBuilderCheckbox(
              name: 'accept_terms',
              title: Text("I accept the terms and conditions"),
              // validator: FormBuilderValidators.equal(true, errorText: 'Required'),
            ),
          ],
        ),
      )

      // Container(
          //   height: 30,
          //   color: Colors.red,
          //   child: TextFormField(
          //     decoration: const InputDecoration(
          //       border: UnderlineInputBorder(),
          //       labelText: 'Enter your username',
          //     ),
          //   ),
          // ),
          // TextField(
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(),
          //     hintText: 'Enter a search term',
          //   ),
          // ),
        ],
      ),
    );
  }
}
