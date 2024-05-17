import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => CourseScreenState();
}

class CourseScreenState extends State<CourseScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Email',
            ),
            validator: (value) {
              // if (value.isEmpty) {
              //   return 'Please enter your email';
              // }
              // You can add email validation logic here if needed
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              // if (value.isEmpty) {
              //   return 'Please enter your name';
              // }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Mobile'),
            validator: (value) {
              // if (value.isEmpty) {
              //   return 'Please enter your mobile number';
              // }
              // You can add mobile number validation logic here if needed
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Game Name'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => {
              // if (_formKey.currentState.validate()) {
              //   // Form is validated, perform desired action
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(content: Text('Form submitted successfully')),
              //   );
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
