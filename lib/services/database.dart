import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Adding a user to the Firestore
  Future<void> addUser(String userId, Map<String, dynamic> userInfoMap) async {
    try {
      await FirebaseFirestore.instance
          .collection("User")
          .doc(userId)
          .set(userInfoMap);
      print("User added successfully!");
    } catch (e) {
      print("Error adding user: $e");
    }
  }

  // Storing transaction details in Firestore
  static Future<void> storeTransactionInFirestore(Map<String, dynamic> transactionData) async {
    try {
      // Use FirebaseFirestore.instance instead of _firestore
      await FirebaseFirestore.instance.collection("transactions").add({
        "products": transactionData["products"], // List of products
        "total": transactionData["total"], // Total amount
        "transaction_date": DateTime.now(),
      });
      print("Transaction stored in Firestore successfully!");
    } catch (e) {
      print("Error storing transaction in Firestore: $e");
    }
  }
}
