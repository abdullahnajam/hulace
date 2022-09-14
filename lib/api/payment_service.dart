import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart';
import 'package:hulace/utils/constants.dart';

class PaymentService {
  void _init() {
    Stripe.publishableKey = stripePublishKey;
  }

  final client = Client();
  static Map<String, String> headers = {
    'Authorization': 'Bearer $stripeSecretKey',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  Future<Map<String, dynamic>> _createCustomer() async {
    final String url = 'https://api.stripe.com/v1/customers';
    var response = await client.post(
      Uri.parse(url),
      headers: headers,
      body: {
        'description': 'new customer'
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to register as a customer.';
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntents(String amount) async {
    final String url = 'https://api.stripe.com/v1/payment_intents';

    Map<String, dynamic> body = {
      'amount': amount,
      'currency': 'myr',
      'payment_method_types[]': 'card'
    };

    var response =
    await client.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(json.decode(response.body));
      throw 'Failed to create PaymentIntents.';
    }
  }

  Future _createCreditCard(String customerId, String paymentIntentClientSecret) async {
    String response="";
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          style: ThemeMode.dark,
          merchantDisplayName: 'Hulace',
          customerId: customerId,
          paymentIntentClientSecret: paymentIntentClientSecret,
        ));

    await Stripe.instance.presentPaymentSheet();
  }

  Future<void> payment(String amount) async {
    _init();
    final _customer = await _createCustomer();
    final _paymentIntent = await _createPaymentIntents(amount);
    await _createCreditCard(_customer['id'], _paymentIntent['client_secret']);
  }
  

}