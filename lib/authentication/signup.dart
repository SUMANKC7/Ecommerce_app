import 'package:ecommerce_application/authentication/loginpage.dart';
import 'package:ecommerce_application/services/database.dart';
import 'package:ecommerce_application/services/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class SignUppage extends StatefulWidget {
  const SignUppage({super.key});

  @override
  State<SignUppage> createState() => _SignUppageState();
}

class _SignUppageState extends State<SignUppage> {
  String? name, email, password;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Future<void> registration() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: const Text(
            "Registered Successfully",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );

      String id = randomAlphaNumeric(10);

      // Save to SharedPreferences
      await SharedPreferenceHelper().saveUserEmail(emailController.text);
      await SharedPreferenceHelper().saveUserName(nameController.text);
      await SharedPreferenceHelper().saveUserId(id);
      await SharedPreferenceHelper().saveUserImage(
        "assests/images/fragrance.png",
      );
      await SharedPreferenceHelper().saveUserNumber(phoneController.text);

      // Save to Firestore
      Map<String, dynamic> userInfoMap = {
        "Name": nameController.text,
        "Email": emailController.text,
        "Id": id,
        "Image": "assests/images/fragrance.png",
        "Phone": phoneController.text,
      };
      await DatabaseMethods().addUser(id, userInfoMap);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Loginpage()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == "weak-password") {
        message = "Password is too weak";
      } else if (e.code == "email-already-in-use") {
        message = "Account already exists";
      } else {
        message = e.message ?? "Something went wrong";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(message, style: const TextStyle(fontSize: 18)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Image.asset(
                  "assests/images/file.png",
                  height: MediaQuery.sizeOf(context).height * 0.2,
                ),
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Name
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Name",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your name" : null,
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Phone
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Phone Number",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your phone number" : null,
                  decoration: InputDecoration(
                    hintText: "Enter your phone number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Email
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Email",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your email" : null,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your password" : null,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      registration();
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(239, 255, 94, 0),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
