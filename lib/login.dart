import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var UserName;
  TextEditingController stname = TextEditingController();
  TextEditingController stpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(UserName.toString()),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Email ID',
                    constraints: BoxConstraints(maxWidth: 300)),
                controller: stname,
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
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    minimumSize: const Size(300, 50)),
                onPressed: () {
                  login();
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  UserName = pref.getString('stid');
                },
                child: Text('click'),
              ),
              Text('${UserName}')
            ],
          )
        ],
      ),
    );
  }

  void login() async {
    var url = Uri.https('akashsir.in', '/myapi/crud/student-login-api.php');
    var response = await http.post(url,
        body: {'st_email': stname.text, 'st_password': stpassword.text});
    print(response.statusCode);
    Map<String, dynamic> mymap = json.decode(response.body);
    var snack = SnackBar(content: Text('${mymap['message']}'));
    ScaffoldMessenger.of(context).showSnackBar(snack);
    if (mymap['flag'] == '1') {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('stid', mymap['st_id'].toString());
    }
  }
}
