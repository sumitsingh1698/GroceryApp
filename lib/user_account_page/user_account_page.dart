import 'package:GroceryApp/data/user_repository.dart';
import 'package:flutter/material.dart';

class UserAccountPage extends StatefulWidget {
  final UserRepository _userRepository;
  UserAccountPage(this._userRepository);

  @override
  State<StatefulWidget> createState() => _UserAccountPageState();
}

class _UserAccountPageState extends State<UserAccountPage> {
  @override
  Widget build(BuildContext context) {
    //List<address> addresLst = loadAddress() as List<address> ;
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(
          'My Account',
        ),
      ),
      body: new Container(
          child: SingleChildScrollView(
              child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          new Container(
            alignment: Alignment.topCenter,
            child: new Container(
                color: Theme.of(context).primaryColorDark,
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.all(50.0),
                  // padding: const EdgeInsets.all(3.0),
                  child: Center(
                    child: ClipOval(
                      child: Icon(
                        Icons.account_circle,
                        size: 150,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
          ),
          new Container(
            child: Card(
              elevation: 1.0,
              child: Column(
                children: <Widget>[
                  new ListTile(
                      leading: Icon(Icons.account_circle,
                          color: Theme.of(context).primaryColorDark),
                      title: new Text("Profile"),
                      subtitle: Text(
                          "${widget._userRepository.userDetail.getFname} ${widget._userRepository.userDetail.getLname},\n${widget._userRepository.userDetail.getEmail}"),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColorDark),
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => UserDetails(
                        //               userRepository: widget._userRepository,
                        //               page: "homepage",
                        //             )));
                      }),
                  Divider(),
                  new ListTile(
                      leading: Icon(Icons.location_on,
                          color: Theme.of(context).primaryColorDark),
                      title: new Text("Address"),
                      subtitle: Text(
                          "house no ${widget._userRepository.userDetail.getHno}, street no ${widget._userRepository.userDetail.getStreetNo}\n${widget._userRepository.userDetail.getAddress} ${widget._userRepository.userDetail.getPincode}"),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColorDark),
                      onTap: () {}),
                  Divider(),
                  new ListTile(
                      leading: Icon(Icons.history,
                          color: Theme.of(context).primaryColorDark),
                      title: new Text("Clear History"),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColorDark),
                      onTap: () {}),
                  Divider(),
                  new ListTile(
                      leading: Icon(Icons.help_outline,
                          color: Theme.of(context).primaryColorDark),
                      title: new Text("Privacy policy"),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColorDark),
                      onTap: () {}),
                  Divider(),
                  new ListTile(
                      leading: Icon(Icons.error_outline,
                          color: Theme.of(context).primaryColorDark),
                      title: new Text("Cookie policy"),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryColorDark),
                      onTap: () {}),
                  Divider(),
                  Container(
                      padding: EdgeInsets.all(30.0),
                      child: Center(
                        child: Text("Created by : Sumit Kumar"),
                      ))
                ],
              ),
            ),
          ),
        ],
      ))),
    );
  }
}
