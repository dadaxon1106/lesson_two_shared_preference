import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lesson_two_shared_preference/pages/register_page.dart';
import 'package:lesson_two_shared_preference/pages/services/log_service.dart';
import 'package:lesson_two_shared_preference/pages/services/prefs_service.dart';

import '../model/user_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String route = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    User? user = await PrefsService.loadUser();
    if (user != null) {
      emailController.text = user.email!;
      passwordController.text = user.password!;
    }


  }
  Future<void> _saveUser() async {
    String enteredName = emailController.text.trim();
    String enteredPassword = passwordController.text.trim();
    if (enteredName.isNotEmpty && enteredPassword.isNotEmpty) {
      User user = User(enteredName, enteredPassword);
      await PrefsService.storeUser(user);
    }
    setState(() {

    },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFf9f7f3),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                "https://img.freepik.com/free-vector/cyber-data-security-online-concept-illustration-internet-security-information-privacy-protection_1150-37328.jpg",
                height: 280,
                width: 400,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Welcome back!", textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                  // textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Log in to your existant account of Q Allure",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Form(
                key: _globalKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          focusColor: Colors.blue.shade800,
                          hintText: "Email",
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            // borderSide: const BorderSide(color: Colors.blue),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide(
                              color: Colors.blue.shade800,
                            ),
                          ),
                          prefixIcon: const Icon(
                            CupertinoIcons.person,
                            // color: Colors.blue,
                            size: 25,
                          ),
                        ),
                        validator: (value) {
                          final gmailRegex = RegExp(r"^(.+)@(\S+)$");
                          if (!gmailRegex.hasMatch(value!)) {
                            return "Please enter correct emsil";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.w500),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: const BorderSide(
                                // color: Colors.blue,
                                ),
                          ),
                          focusColor: Colors.blue,
                          prefixIcon: const Icon(
                            CupertinoIcons.lock_open,
                            // color: Colors.blue,
                            size: 25,
                          ),
                        ),
                        validator: (value) {
                          final symbolHas = RegExp("[!A-Za-z0-9]");
                          final upperLetter = RegExp("[A-Z]");
                          final numberHas = RegExp("[0-9]");
                          if (!symbolHas.hasMatch(value!)) {
                            return "Must be symbol";
                          }
                          if (!upperLetter.hasMatch(value)) {
                            return "Must be upperletter";
                          }
                          if (!numberHas.hasMatch(value)) {
                            return "Must be number";
                          }
                          return null;
                        },
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Text(""),
                        Text(
                          "Forgot Password ?  ",
                          style: TextStyle(color: Colors.purple, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () async {
                        await _saveUser();
                        PrefsService.loadUser().then((value){
                          return LogService.w(value!.toJson().toString());
                        });
                        _globalKey.currentState!.validate();
                      },
                      child: Ink(
                        child: Container(
                          alignment: Alignment.center,
                          width: 220,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            "LOG IN",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Or connect using",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 160,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue.shade800,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.facebook,
                          color: Colors.white,
                        ),
                        Text(
                          "Facebook",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.red,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.g_mobiledata_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          "Google",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterPage.route);
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
