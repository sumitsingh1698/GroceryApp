import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/orders/models/order.dart';
import 'package:GroceryApp/orders/orders_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  final Order order;
  final String phoneNo;
  final String email;
  final UserRepository userRepository;
  PaymentPage(
      {@required this.userRepository,
      @required this.order,
      @required this.phoneNo,
      @required this.email});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  static const platform = const MethodChannel("razorpay_flutter");
  Razorpay _razorpay;
  int totalprice;

  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    afterSuccessOrder(response.paymentId, 11);
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (response.code == 2) {
      Navigator.pop(context);
    }

    try {
      print("\n\n\n\n Message : \n\n" +
          response.code.toString() +
          " - " +
          response.message);
      Fluttertoast.showToast(
          msg: "ERROR: " + response.code.toString() + " - " + response.message,
          timeInSecForIos: 4);
    } catch (e) {
      print(e);
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (response.walletName == 'paytm') {}

    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_xC5uff9BtKo4XX',
      'amount': totalprice,
      'name': 'S Kart',
      'description': 'Best Grocery Delivery Service',
      'prefill': {'contact': '${widget.phoneNo}', 'email': '${widget.email}'},
      'external': {'wallets': []}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    totalprice = (widget.order.orderPrice * 100).toInt();
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Payments"),
        ),
        body: Container(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    onPressed: openCheckout,
                    child: Text("Payment Methods"),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor),
                RaisedButton(
                    onPressed: onCashOnDelivery,
                    child: Text("Cash on Delivery"),
                    textColor: Colors.white,
                    color: Theme.of(context).accentColor),
              ],
            ))),
      ),
    );
  }

  void onCashOnDelivery() {
    afterSuccessOrder("cash", 12);
  }

  void afterSuccessOrder(String paymentId, int paymentStatusCode) {
    print("\n\n\n\nandle here\n\n");
    widget.userRepository
        .addOrderDetail(Order(
            custormerId: widget.order.custormerId,
            orderDateTime: DateTime.now(),
            orderId: "",
            orderPrice: widget.order.orderPrice,
            statusCode: 21,
            paymentStatusCode: paymentStatusCode,
            paymentId: paymentId,
            products: widget.order.products))
        .then((value) => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OrderParent(userRepository: widget.userRepository)))
            });
  }
}
