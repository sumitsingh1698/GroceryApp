import 'package:GroceryApp/authenticate/authentication_bloc.dart';
import 'package:GroceryApp/authenticate/authentication_event.dart';
import 'package:GroceryApp/data/user_repository.dart';
import 'package:GroceryApp/products_insertion/add_product.dart';
import 'package:GroceryApp/user_account_page/user_account_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage_Drawer extends StatelessWidget {
  UserRepository _userRepository;
  HomePage_Drawer(this._userRepository);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white12,
        child: new ListView(
          children: <Widget>[
            new Card(
              elevation: 4.0,
              child: new Column(
                children: <Widget>[
                  new ListTile(
                      leading: Icon(Icons.account_circle,
                          color: Theme.of(context).primaryColorDark),
                      title: new Text("${_userRepository.userDetail.getFname}"),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColorDark),
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> UserAccountPage(_userRepository)));
                      }),
                  Divider(),
                  new ListTile(
                      leading: Icon(Icons.shopping_cart,
                          color: Theme.of(context).primaryColorDark),
                      title: new Text("My Cart"),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart_screen()));
                      }),
                  new Divider(),
                  new ListTile(
                      leading: Icon(Icons.history,
                          color: Theme.of(context).primaryColorDark),
                      title: new Text("Order History "),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> Oder_History(toolbarname: ' Order History',)));
                      }),
                  new Divider(),
                  new ListTile(
                      leading: Icon(Icons.headset,
                          color: Theme.of(context).primaryColorDark),
                      title: new Text("Support & FAQs"),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> Help_Screen(toolbarname: 'Help',)));
                      }),
                      Divider(),
                      new ListTile(
                      leading: Icon(Icons.headset,
                          color: Theme.of(context).primaryColorDark),
                      title: new Text("Add Product"),
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> AddProductPage(userRepository: _userRepository)));
                      })
                ],
              ),
            ),
            new Card(
              elevation: 4.0,
              child: new Column(
                children: <Widget>[],
              ),
            ),
            new Card(
              elevation: 4.0,
              child: new ListTile(
                  leading: Icon(Icons.power_settings_new,
                      color: Theme.of(context).primaryColorDark),
                  title: new Text(
                    "Logout",
                    style:
                        new TextStyle(color: Colors.redAccent, fontSize: 17.0),
                  ),
                  onTap: () {
                   BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                  }),
            )
          ],
        ),
      ),
    );
  }
}
