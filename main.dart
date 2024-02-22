import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Input and Validation',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Student Information Form'),
        ),
        body: const StudentForm(),
      ),
    );
  }
}

class StudentForm extends StatefulWidget {
  const StudentForm({super.key});

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String? _validateID(String? value) {
    final isNum = RegExp(r'^[0-9]+');
    if (isNum.hasMatch(value!)) {
      if (value.toString().isEmpty) {
        return 'ID cannot be empty';
      }
      if (value.toString().length != 11) {
        return 'ID must be 11 characters long';
      }
      return null;
    } else {
      return 'ID must be a number';
    }
  }

  _submitForm() {
    if (_formKey.currentState!.validate()) {
      // print('ID: ${_idController.text}');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Student Information'),
            content: SizedBox(
              height: 100,
              child: Column(
                children: [
                  Text('Name: ${_nameController.text}'),
                  Text('ID: ${_idController.text}'),
                  Text('Email: ${_emailController.text}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: "Enter your Name",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _idController,
              validator: _validateID,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter your Student ID",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Plese enter Email';
                } else {
                  final isEmail = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                  if (isEmail.hasMatch(value)) {
                    return null;
                  } else {
                    return "Email Format Incorrect";
                  }
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Enter your Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: _submitForm,
              child: const Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}
