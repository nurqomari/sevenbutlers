import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mollie/mollie.dart';
import 'package:sevenbutlers/domain/user.dart';
import 'package:sevenbutlers/ui/merchants.dart';
import 'package:sevenbutlers/utils/services/session_manager.dart';
import 'package:sevenbutlers/utils/services/social_login_service.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var user = new UserData();

  @override
  void initState() {
    super.initState();
    setUser();
  }

  void clearLogin() {
    SessionManager session = SessionManager();
    SocialLoginService loginService = new SocialLoginService();
    loginService.signOut();
    session.clear();
  }

  void setUser() async {
    SessionManager session = SessionManager();
    user = await session.getUser();
  }

  MollieOrderRequest o = new MollieOrderRequest(
      amount: MollieAmount(value: "1396.00", currency: "EUR"),
      orderNumber: "900",
      redirectUrl: "mollie://payment-return",
      locale: "de_DE",
      webhookUrl: 'https://favorestodevapi.azurewebsites.net/webhook',
      // payment_option: 1,
      // phone: "string",
      billingAddress: new MollieAddress(
        organizationName: 'Mollie B.V.',
        streetAndNumber: 'Keizersgracht 313',
        city: 'Amsterdam',
        region: 'Noord-Holland',
        postalCode: '1234AB',
        country: 'DE',
        title: 'Dhr.',
        givenName: 'Piet',
        familyName: 'Mondriaan',
        email: 'piet@mondriaan.com',
        phone: '+31309202070',
      ),
      shippingAddress: new MollieAddress(
        organizationName: 'Mollie B.V.',
        streetAndNumber: 'Keizersgracht 313',
        city: 'Amsterdam',
        region: 'Noord-Holland',
        postalCode: '1234AB',
        country: 'DE',
        title: 'Dhr.',
        givenName: 'Piet',
        familyName: 'Mondriaan',
        email: 'piet@mondriaan.com',
        phone: '+31309202070',
      ),
      products: [
        MollieProductRequest(
          type: 'physical',
          sku: '5702016116977',
          name: 'LEGO 42083 Bugatti Chiron',
          productUrl: 'https://shop.lego.com/nl-NL/Bugatti-Chiron-42083',
          imageUrl:
              'https://sh-s7-live-s.legocdn.com/is/image//LEGO/42083_alt1?',
          quantity: 2,
          vatRate: '21.00',
          unitPrice: MollieAmount(
            currency: 'EUR',
            value: '399.00',
          ),
          totalAmount: MollieAmount(
            currency: 'EUR',
            value: '698.00',
          ),
          discountAmount: MollieAmount(
            currency: 'EUR',
            value: '100.00',
          ),
          vatAmount: MollieAmount(
            currency: 'EUR',
            value: '121.14',
          ),
        ),
        MollieProductRequest(
          type: 'physical',
          sku: '5702016116977',
          name: 'LEGO 42083 Bugatti Chiron',
          productUrl: 'https://shop.lego.com/nl-NL/Bugatti-Chiron-42083',
          imageUrl:
              'https://sh-s7-live-s.legocdn.com/is/image//LEGO/42083_alt1?',
          quantity: 2,
          vatRate: '21.00',
          unitPrice: MollieAmount(
            currency: 'EUR',
            value: '399.00',
          ),
          totalAmount: MollieAmount(
            currency: 'EUR',
            value: '698.00',
          ),
          discountAmount: MollieAmount(
            currency: 'EUR',
            value: '100.00',
          ),
          vatAmount: MollieAmount(
            currency: 'EUR',
            value: '121.14',
          ),
        )
      ]);

  Future<void> createOrder(MollieOrderRequest order) async {
    // use this in a new widget with a future builder

    //only client example
    // client.init('test_HbkjP7PuCPwdveGWG2UffGTdkmd8re');

    // //Test
    // MollieSubscriptionRequest s = new MollieSubscriptionRequest(
    //   amount: MollieAmount(
    //     currency: 'EUR',
    //     value: '25.00',
    //   ),
    //   times: 4,
    //   interval: '3 months',
    //   description: 'Quarterly payment',
    //   webhookUrl: 'https://webshop.example.org/subscriptions/webhook/',
    // );

    // MolliePaymentRequest r = new MolliePaymentRequest(
    //   amount: MollieAmount(
    //     currency: 'EUR',
    //     value: '30.00',
    //   ),
    //   description: 'My first payment',
    //   redirectUrl: 'https://webshop.example.org/order/12345/',
    //   webhookUrl: 'https://webshop.example.org/payments/webhook/',
    // );

    // var payment = await client.payments.listPayments();
    // print(payment.length);

    // client-server example
    Dio dio = new Dio();
    dio.options.headers["authorization"] = "bearer ${user.access_token}";
    var orderResponse = await dio.post(
        "https://favorestodevapi.azurewebsites.net/v.1/order",
        data: order.toJson());

    var data = json.decode(orderResponse.data);
    MollieOrderResponse res = MollieOrderResponse.build(data);

    Mollie.setCurrentOrder(res);

    Mollie.startPayment(res.checkoutUrl);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: RaisedButton(onPressed: () {
  //         createOrder(null);
  //       }),
  //     ),
  //   );
  //   /*MollieCheckout(
  //     order: o,
  //     onMethodSelected: (order) {
  //       createOrder(order);
  //     },
  //     useCredit: true,
  //     usePaypal: true,
  //     useApplePay: true,
  //     useSofort: true,
  //     useSepa: true,
  //     useIdeal: true,
  //   );*/
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to SevenButlers"),
        elevation: 0.1,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          // Center(child: Text(user.email)),
          SizedBox(height: 50),
          Center(child: Text(user.name ?? '')),
          SizedBox(height: 100),
          RaisedButton(
            onPressed: () {
              clearLogin();
              Navigator.pushNamedAndRemoveUntil(
                  context, "/login1", (route) => false);
            },
            child: Text("Logout"),
            color: Colors.lightBlueAccent,
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                createOrder(o);
              },
              child: Text('Checkout'),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MapWidget()));
              },
              child: Text('View Merchants'),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowOrderStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MollieOrderStatus(
      orders: [Mollie.getCurrentOrder()],
    );
  }
}
