import 'dart:core';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'paypal_service.dart';




class PaypalPayment extends StatefulWidget {
  final Function onFinish;
  final String amount;

  const PaypalPayment({super.key, required this.onFinish, required this.amount});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? checkoutUrl;
  String? executeUrl;
  String? accessToken;
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams();
        final res =
        await services.createPaypalPayment(transactions, accessToken);
        setState(() {
          checkoutUrl = res["approvalUrl"]!;
          executeUrl = res["executeUrl"]!;
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  int quantity = 1;

  Map<String, dynamic> getOrderParams() {

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            // "total": widget.amount,
            "total": "1",
            "currency": defaultCurrency["currency"],
            "details": {
              // "subtotal": widget.amount,
              "subtotal": "1",
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },

        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  // ignore_for_file: deprecated_member_use
  @override
  Widget build(BuildContext context) {
    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: Icon(
                Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
                NavigationDelegate(
                    onNavigationRequest: (NavigationRequest request){
                      if (request.url.contains(returnURL)) {
                        final uri = Uri.parse(request.url);
                        final payerID = uri.queryParameters['PayerID'];
                        if (payerID != null) {
                          services
                              .executePayment(executeUrl, payerID, accessToken)
                              .then((id) {
                            widget.onFinish(id);
                          });
                        } else {
                          Navigator.of(context).pop();
                        }
                        Navigator.of(context).pop();
                      }
                      if (request.url.contains(cancelURL)) {
                        Navigator.of(context).pop();
                      }
                      return NavigationDecision.navigate;
                    }
                )
            )
            ..loadRequest(Uri.parse(checkoutUrl!)),
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
  }
}