import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> makePayment(
    String amount,
    String currency,
    Map<String, dynamic> productDetails,
  ) async {
    try {
      // 1) Create PaymentIntent on Stripe
      final paymentIntent = await _createPaymentIntent(amount, currency);
      if (paymentIntent == null || paymentIntent["client_secret"] == null) {
        debugPrint("❌ PaymentIntent creation failed or client_secret missing");
        return;
      }
      final clientSecret = paymentIntent["client_secret"];

      // 2) Init PaymentSheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          style: ThemeMode.dark,
          merchantDisplayName: "Your Merchant Name",
        ),
      );
      debugPrint("✅ PaymentSheet initialized");

      // 3) Present sheet
      await _presentPaymentSheet(productDetails);
    } catch (e) {
      debugPrint("❌ makePayment exception: $e");
    }
  }

  static Future<Map<String, dynamic>?> _createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      final secret = dotenv.env['STRIPE_SECRET_KEY'];
      if (secret == null || secret.isEmpty) {
        debugPrint("❌ STRIPE_SECRET_KEY missing from .env");
        return null;
      }

      final body = {
        "amount": _calculateAmount(amount),
        "currency": currency,
        "payment_method_types[]": "card",
      };

      final response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": "Bearer $secret",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: body,
      );

      debugPrint("Stripe status: ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("✅ PaymentIntent created");
        return jsonDecode(response.body);
      } else {
        debugPrint("❌ Stripe error: ${response.body}");
      }
    } catch (err) {
      debugPrint("❌ _createPaymentIntent error: $err");
    }
    return null;
  }

  static Future<void> _presentPaymentSheet(
    Map<String, dynamic> productDetails,
  ) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      debugPrint("✅ Payment successful");
      await _storeTransactionInFirestore(productDetails);
    } on StripeException catch (e) {
      debugPrint("⚠️ Stripe cancelled/failed: ${e.error.localizedMessage}");
    } catch (e) {
      debugPrint("❌ presentPaymentSheet error: $e");
    }
  }

  static Future<void> _storeTransactionInFirestore(
    Map<String, dynamic> productDetails,
  ) async {
    try {
      await _firestore.collection("transactions").add({
        "product_name": productDetails["name"],
        "product_id": productDetails["id"],
        "price": productDetails["price"],
        "quantity": productDetails["quantity"],
        "transaction_date": DateTime.now(),
      });
      debugPrint("✅ Transaction stored in Firestore");
    } catch (e) {
      debugPrint("❌ Firestore write error: $e");
    }
  }

  static String _calculateAmount(String amount) {
    try {
      final dollars = double.parse(amount);
      final cents = (dollars * 100).toInt();
      return cents.toString();
    } catch (e) {
      debugPrint("❌ amount parse error: $e");
      return "0";
    }
  }
}
