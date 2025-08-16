// import 'package:ecommerce_application/pages/home.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthMethods {
//   final FirebaseAuth auth = FirebaseAuth.instance;

//   getCurrentUser() async {
//     return await auth.currentUser;
//   }

//   signInWithGoogle(BuildContext context) async {
//     final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//     final GoogleSignIn googleSignIn = GoogleSignIn();

//     try {
//       final GoogleSignInAccount? googleSignInAccount =
//           await googleSignIn.signIn();
//       if (googleSignInAccount == null) {
//         // User cancelled the sign-in process
//         return;
//       }

//       final GoogleSignInAuthentication? googleSignInAuthentication =
//           await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//           idToken: googleSignInAuthentication?.idToken,
//           accessToken: googleSignInAuthentication?.accessToken);

//       UserCredential result =
//           await firebaseAuth.signInWithCredential(credential);

//       User? userdetail = result.user;

//       if (userdetail != null) {
//         Map<String, dynamic> userInfomap = {
//           "email": userdetail.email,
//           "name": userdetail.displayName,
//           "imgUrl": userdetail.photoURL,
//           "id": userdetail.uid,
//           "phone": userdetail.phoneNumber,
//         };
//         await DatabaseMethods()
//             .addUser(userdetail.uid, userInfomap)
//             .then((value) {
//           Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => Homescreen(categories: [])));
//         });
//       }
//     } catch (e) {
//       print("Error during Google Sign-In: $e");
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text("Sign-In failed: $e"),
//       ));
//     }
//   }

//   Future SignOut() async {
//     await FirebaseAuth.instance.signOut();
//   }

//   Future deleteUser() async {
//     User? user = await FirebaseAuth.instance.currentUser;
//     user?.delete();
//   }
// }
