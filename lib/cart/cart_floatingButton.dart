import 'package:GroceryApp/cart/cart_page.dart';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:flutter/material.dart';

class CartFloatingButton extends StatelessWidget {
  final UserRepository userRepository;
  CartFloatingButton(this.userRepository);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          print("length in cart" +
              userRepository.userDetail.getCart.length.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CartScreenParent(
                        userRepository: userRepository,
                      )));
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 8, top: 10),
              child: new IconButton(
                  icon: new Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 50.0,
                  ),
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart_screen()));
                  }),
            ),
            userRepository.userDetail.getCart.length == 0
                ? new Container()
                : new Positioned(
                    child: new Stack(
                    children: <Widget>[
                      new Positioned(
                          right: 40,
                          bottom: 43,
                          child: CircleAvatar(
                              backgroundColor: Colors.orange,
                              radius: 13.0,
                              child: Text(
                                //widget.userDetail.getCart.length
                                userRepository.userDetail.getCart.length
                                    .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white),
                              ))),
                    ],
                  )),
          ],
        ),
      ),
    );
  }
}
