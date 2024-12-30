import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController stname = TextEditingController();
  TextEditingController stemail = TextEditingController();
  TextEditingController stmobile = TextEditingController();
  TextEditingController stpassword = TextEditingController();
  String gender = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Name',
                    constraints: BoxConstraints(maxWidth: 300)),
                controller: stname,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Email ID',
                    constraints: BoxConstraints(maxWidth: 300)),
                controller: stemail,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RadioListTile(
                          activeColor: Colors.green,
                          value: "Male",
                          title: const Text('Male'),
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                            });
                          }),
                    ),
                    Expanded(
                      child: RadioListTile(
                          activeColor: Colors.green,
                          value: "Female",
                          title: Text('Female'),
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                            });
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Mobile',
                    constraints: BoxConstraints(maxWidth: 300)),
                controller: stmobile,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Password',
                    constraints: BoxConstraints(maxWidth: 300)),
                controller: stpassword,
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  registration();
                },
                child: const Text('Registered'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: const Text('Do You Already Registered ?'))
            ],
          ),
        ),
      ]),
    );
  }

  void registration() async {
    var url = Uri.https('akashsir.in', '/myapi/crud/student-add-api.php');
    var response = await http.post(url, body: {
      'st_name': stname.text,
      'st_gender': gender.toString(),
      'st_email': stemail.text,
      'st_mobileno': stmobile.text,
      'st_password': stpassword.text,
    });
    print(response.statusCode);
    print(response.body);
    Map<String, dynamic> mymap = json.decode(response.body);
    var snack = SnackBar(content: Text('${mymap['message']}'));
    ScaffoldMessenger.of(context).showSnackBar(snack);
    if (response.statusCode == 200 && mymap['flag'] == '1') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }
}
