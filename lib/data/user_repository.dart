import 'package:GroceryApp/models/user_detail.dart';
import 'package:GroceryApp/orders/models/order.dart';
import 'package:GroceryApp/products_insertion/models/product.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:connectivity/connectivity.dart';
import "package:firebase_auth/firebase_auth.dart";

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final UserDetail userDetail;
  String phoneNumber;

  // Constructor -----------------------------------------------------

  UserRepository({FirebaseAuth firebaseAuth, UserDetail userDetail})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        userDetail = userDetail ?? UserDetail();

  //Send Otp ---------------------------------------------------------

  Future<void> sendOtp(
      String phoneNumber,
      Duration timeOut,
      PhoneVerificationFailed phoneVerificationFailed,
      PhoneVerificationCompleted phoneVerificationCompleted,
      PhoneCodeSent phoneCodeSent,
      PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeOut,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }

  //verify and Login --------------------------------------------

  Future<AuthResult> verifyAndLogin(
      String verificationId, String smsCode) async {
    AuthCredential authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationId, smsCode: smsCode);

    return _firebaseAuth.signInWithCredential(authCredential);
  }

  //Get user --------------------------------------------------------

  Future<FirebaseUser> getUser() async {
    var user = await _firebaseAuth.currentUser();
    return user;
  }

  //signout ---------------------------------------------------------

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  //get details ------------------------------------------------------

  Future<void> getDetails() async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'getUserDetail',
    );
    await callable.call().then((value) {
      print("data ${value.data['data']['values']}");
      userDetail.setUid = value.data['data']['id'];
      userDetail.setEmail = value.data['data']['values']['email'];
      userDetail.setPhoneNo = value.data['data']['values']['phoneNo'];
      userDetail.setFname = value.data['data']['values']['fname'];
      userDetail.setLname = value.data['data']['values']['lname'];
      userDetail.setCart = value.data['data']['values']['cart'];
      userDetail.setCreateDate =
          value.data['data']['values']['createdDate']['date'];

      userDetail.setHno = value.data['data']['values']['address']['hno'];
      userDetail.setFloor = value.data['data']['values']['address']['floor'];
      userDetail.setStreetNo =
          value.data['data']['values']['address']['streetNo'];
      userDetail.setAddress =
          value.data['data']['values']['address']['address'];
      userDetail.setLandmark =
          value.data['data']['values']['address']['landmark'];
      userDetail.setPincode =
          value.data['data']['values']['address']['pincode'];
    });
  }

  //update Personal Details -----------------------------------------

  Future<void> updatePersonalDetails(
      String email, String fname, String lname) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'upadateUserPersonalDetail',
    );
    final HttpsCallableResult result = await callable.call(
      <String, dynamic>{
        'email': email,
        'fname': fname,
        'lname': lname,
      },
    );
    print("update persnal success : ${result.data}");
  }

  //update address details -------------------------------------------
  Future<void> updateAddressDetails(String hno, String floor, String streetNo,
      String address, String landmark, String pincode) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'upadateUserAddressDetail',
    );
    final HttpsCallableResult result = await callable.call(
      <String, dynamic>{
        'hno': hno,
        'floor': floor,
        'streetNo': streetNo,
        'address': address,
        'landmark': landmark,
        'pincode': pincode,
      },
    );
    print("update address success : ${result.data}");
  }

  //Check Connnectivity -----------------------------------------------

  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  //------------------------------------------------------------------------
  //Add Product

  Future<void> addProduct(Product product) async {
    print("enter in add product");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'addProduct',
    );
    print("enter in second product");
    final HttpsCallableResult result = await callable.call(
      <String, dynamic>{
        'name': product.name,
        'oprice': product.oprice,
        'discount': product.discount,
        'pkt': product.pkt,
        'quantity': product.quantity,
        'qgiven': product.qgiven,
        'scat': product.scat,
        'cat': product.cat
      },
    );
    print("update persnal success : ${result.data}");
  }

  //------------------------------------------------------------------/////////////////////

  // Get Subcategories of the Categories

  Future<List> getSubcat(String cat) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'getSubCategories',
    );
    List<dynamic> subcat;
    await callable.call(
      <String, dynamic>{
        'cat': cat,
      },
    ).then((value) {
      subcat = value.data['data']['values']['subcats'];
    });

    return subcat;
  }
  //----------------------------------------------------------///////////////////////

  // Get List of Product by online  --------------------------------------

  Future<List> getProductList(String cat, String subcat) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'getProductList',
    );
    List<Product> products = [];
    await callable.call(
      <String, dynamic>{
        'cat': cat,
        'subcat': subcat,
      },
    ).then((value) {
      print(value.data['data']['values'][0]['name']);
      int noe = value.data['data']['values'].length;
      for (int i = 0; i < noe; i++) {
        products.add(Product(
          productId: value.data['data']['values'][i]['id'],
          name: value.data['data']['values'][i]['name'],
          cat: value.data['data']['values'][i]['cat'],
          oprice: value.data['data']['values'][i]['oprice'],
          scat: value.data['data']['values'][i]['scat'],
          pkt: value.data['data']['values'][i]['pkt'],
          discount: value.data['data']['values'][i]['discount'],
          qgiven: value.data['data']['values'][i]['qgiven'],
          quantity: value.data['data']['values'][i]['quantity'],
          imageurl: value.data['data']['values'][i]['imageurl'],
        ));
      }
    });

    return products;
  }

  //----------------------------------------------------

  // Add Product to cart

  bool addToCart(String productId) {
    print("add to CArt");

    if (!userDetail.insertInCart(productId)) {
      return false;
    }
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'addToCart',
    );
    try {
      callable.call(
        <String, dynamic>{
          'productId': productId,
        },
      );
    } catch (e) {
      print(e);
    }
    return true;
  }

  // delete to Cart ------------------------------------------------
  bool deleteToCart(String productId) {
    print("add to CArt");

    if (!userDetail.deleteInCart(productId)) {
      return false;
    }
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'deleteToCart',
    );
    try {
      callable.call(
        <String, dynamic>{
          'productId': productId,
        },
      );
    } catch (e) {
      print(e);
    }
    return true;
  }

  // ------------------------------------------------------

  // Get Products for Carts

  Future<List> getProductsForCart() async {
    print("get product for cart");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'getProductListOfCart',
    );
    List<Product> products = [];
    await callable.call(
      <String, dynamic>{'productsId': userDetail.getCart},
    ).then((value) {
      // print(value.data['data']['values'][0]['name']);
      int noe = value.data['data']['values'].length;
      for (int i = 0; i < noe; i++) {
        products.add(Product(
          productId: value.data['data']['values'][i]['id'],
          name: value.data['data']['values'][i]['name'],
          cat: value.data['data']['values'][i]['cat'],
          oprice: value.data['data']['values'][i]['oprice'],
          scat: value.data['data']['values'][i]['scat'],
          pkt: value.data['data']['values'][i]['pkt'],
          discount: value.data['data']['values'][i]['discount'],
          qgiven: value.data['data']['values'][i]['qgiven'],
          quantity: value.data['data']['values'][i]['quantity'],
          imageurl: value.data['data']['values'][i]['imageurl'],
        ));
      }
    });

    return products;

    //------------------------------------------------------------------
  }
  // Order Update to Database ----------------------------------------

  Future<void> addOrderDetail(Order order) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'updateOrder',
    );
    try {
      return callable.call(
        <String, dynamic>{
          'orderId': order.orderId,
          'orderPrice': order.orderPrice,
          'statusCode': order.statusCode,
          'paymentStatusCode': order.paymentStatusCode,
          'paymentId': order.paymentId,
          'products': order.products,
          'custormerId': order.custormerId
        },
      );
    } catch (e) {
      print(e);
    }
  }

  //---------------------------------------------------------------
  Future<void> updateCartOfUser() async {
    print("update cart in userRepository");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'updateCart',
    );
    await callable.call().then((value) {
      userDetail.setCart = value.data['data']['values']['cat'];
    });
    print(" successfully update cart in userRepository");
  }

  //--------------------------------------------------------------

  //-----------------------------------------------------------------

  Future<List> getAllOrderDetails() async {
    print("get all order");
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'getOrderList',
    );
    List<Order> orders = [];
    // print(
    // "order length in getallorderdetail ${userDetail.getOrderList.length}");
    await callable.call().then((value) {
      print("eeeeee" + value.data.toString());
      print(DateTime.fromMillisecondsSinceEpoch(value.data['data']['values'][0]
                  ['orderDateTime']['_seconds'] *
              1000)
          .toString());
      int noe = value.data['data']['values'].length;
      print(noe);
      if (noe > 0) {
        for (int i = 0; i < noe; i++) {
          // print(value.data['data']['values'][1]['orderPrice']);
          orders.add(Order(
            orderId: value.data['data']['values'][i]['orderId'],
            orderPrice:
                (value.data['data']['values'][i]['orderPrice']).toDouble(),
            orderDateTime: new DateTime.fromMillisecondsSinceEpoch(
                value.data['data']['values'][i]['orderDateTime']['_seconds'] *
                    1000),
            statusCode: value.data['data']['values'][i]['statusCode'],
            products: value.data['data']['values'][i]['products'],
            paymentId: value.data['data']['values'][i]['paymentId'],
            paymentStatusCode: value.data['data']['values'][i]
                ['paymentStatusCode'],
            custormerId: value.data['data']['values'][i]['custormerId'],
          ));
        }
      }
    });
    return orders;
  }

  //------------------------------------------------------------------
}
